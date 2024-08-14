class EnvironmentsController < ApplicationController
  layout 'sidebar'

  before_action :set_project
  before_action :set_environment, only: [:show, :edit, :update, :destroy]
  before_action :set_sidebar_partial

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
      render :new, flash: { error: 'Environment creation failed.' }
    end
  end

  def edit
  end

  def update
    if @environment.update(environment_params)
      redirect_to project_environment_path(@project, @environment), flash: { success: 'Environment updated successfully!' }
    else
      render :edit, flash: { error: 'Environment update failed.' }
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

  def set_project
    @project = current_user.projects.find_by!(token: params[:project_token])
  end

  def set_environment
    @environment = @project.environments.find_by!(token: params[:token])
  end

  def environment_params
    params.require(:environment).permit(:name)
  end

  def set_sidebar_partial
    @sidebar_partial = 'projects'
  end
end
