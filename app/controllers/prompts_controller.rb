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
    deployment = Deployment.new(prompt: @prompt, environment: environment, is_static: deploy_params[:is_static])
    if deployment.save
      redirect_to [@project, @prompt], flash: { success: 'Prompt was successfully deployed.' }
    else
      render :show, status: :unprocessable_entity, flash: { error: 'Failed to deploy the prompt. Please try again.' }
    end
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
