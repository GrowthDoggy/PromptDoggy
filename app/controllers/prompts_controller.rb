class PromptsController < ConsoleController
  before_action :set_prompt, only: [:show, :edit, :update, :destroy, :deploy]

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
      redirect_to [@project, @prompt], notice: 'Prompt was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    sanitized_params = prompt_params.except(:name)
    if @prompt.update(sanitized_params)
      redirect_to [@project, @prompt], notice: 'Prompt was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @prompt.destroy
    redirect_to project_prompts_path(@project), notice: 'Prompt was successfully deleted.'
  end

  def deploy
    environment = @project.environments.find(params[:environment_id])
    is_static = params[:is_static] == 'true'

    Deployment.create!(prompt: @prompt, environment: environment, is_static: is_static)

    redirect_to [@project, @prompt], notice: 'Prompt was successfully deployed.'
  end

  private

  def set_prompt
    @prompt = @project.prompts.find(params[:id])
  end

  def prompt_params
    params.require(:prompt).permit(:name, :content)
  end
end
