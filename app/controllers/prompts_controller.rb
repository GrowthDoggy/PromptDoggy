class PromptsController < ConsoleController
  before_action :set_prompt, only: [:show, :edit, :update, :destroy, :deploy]

  rescue_from ActionController::ParameterMissing, with: :handle_missing_param

  def index
    @prompts = @project.prompts
  end

  def show
  end

  def new
    @prompt = @project.prompts.build
  end

  def create
    @prompt = @project.prompts.build(prompt_params)
    if @prompt.save
      redirect_to [@project, @prompt], flash: { success: 'Prompt was successfully created.' }
    else
      render :new, status: :unprocessable_entity, flash: { error: 'Failed to create the prompt. Please try again.' }
    end
  end

  def edit
  end

  def update
    sanitized_params = prompt_params.except(:name)
    if @prompt.update(sanitized_params)
      redirect_to [@project, @prompt], flash: { success: 'Prompt was successfully updated.' }
    else
      render :edit, status: :unprocessable_entity, flash: { error: 'Failed to update the prompt. Please try again.' }
    end
  end

  def destroy
    @prompt.destroy
    redirect_to project_prompts_path(@project), notice: 'Prompt was successfully deleted.'
  end

  def deploy
    environment = @project.environments.find(deploy_params[:environment_id])

    ActiveRecord::Base.transaction do
      deployment = Deployment.new(prompt: @prompt, environment: environment, is_static: deploy_params[:is_static])
      deployment.save!

      # Purge the existing file if it exists
      # https://api.rubyonrails.org/v7.1/classes/ActiveStorage/Blob.html
      # Blobs are intended to be immutable in as-so-far as their reference to a specific file goes. You’re allowed to update a blob’s metadata on a subsequent pass, but you should not update the key or change the uploaded file. If you need to create a derivative or otherwise change the blob, simply create a new blob and purge the old one.
      if @prompt.deployed_file.attached?
        @prompt.deployed_file.purge
      end

      # Attach the new file
      @prompt.deployed_file.attach(
        io: StringIO.new(@prompt.to_json),
        key: "prompts/#{@project.token}/#{environment.token}/#{@prompt.name}.json",
        filename: "#{@project.token}_#{environment.token}_#{@prompt.name}.json",
        content_type: "application/json"
      )
    end

    # If the transaction is successful, redirect the user
    redirect_to [@project, @prompt], flash: { success: 'Prompt was successfully deployed.' }

  rescue ActiveRecord::RecordInvalid
    # If the save fails or any other ActiveRecord-related error occurs, render the form again
    flash.now[:error] = 'Failed to deploy the prompt. Please try again.'
    render :show, status: :unprocessable_entity
  end

  private

  def set_prompt
    @prompt = @project.prompts.find(params[:id])
  end

  def prompt_params
    params.require(:prompt).permit(:name, :content)
  end

  def deploy_params
    params.permit(:environment_id, :is_static).tap do |deployment_params|
      raise ActionController::ParameterMissing.new(:environment_id) if deployment_params[:environment_id].blank?
      deployment_params[:is_static] = false unless deployment_params.key?(:is_static)
    end
  end

  def handle_missing_param(exception)
    flash.now[:warning] = "Param #{exception.param} is required."
    render :show, status: :forbidden
  end
end
