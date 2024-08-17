class EnvironmentsController < ConsoleController
  before_action :set_environment, only: [:show, :edit, :update, :destroy]

  def index
    @environments = @project.environments
  end

  def show
  end

  def new
    @environment = @project.environments.new
  end

  def create
    @environment = @project.environments.new(environment_params)
    if @environment.save
      redirect_to project_environment_path(@project, @environment), flash: { success: 'Environment created successfully!' }
    else
      render :new, status: :internal_server_error, flash: { error: 'Environment creation failed.' }
    end
  end

  def edit
  end

  def update
    if @environment.update(environment_params)
      redirect_to project_environment_path(@project, @environment), flash: { success: 'Environment updated successfully!' }
    else
      render :edit, status: :internal_server_error, flash: { error: 'Environment update failed.' }
    end
  end

  def destroy
    if @environment.destroy
      redirect_to project_environments_path(@project), flash: { success: 'Environment deleted successfully!' }
    else
      redirect_to project_environment_path(@project, @environment), flash: { error: 'Environment deletion failed.' }
    end
  end

  private

  def set_environment
    @environment = @project.environments.find_by!(token: params[:token])
  end

  def environment_params
    params.require(:environment).permit(:name)
  end
end
