class ProjectsController < ApplicationController
  layout 'sidebar'

  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user

  def index
    @projects = current_user.projects
  end

  def show
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to @project, flash: { success: "Project created successfully!" }
    else
      render :new, status: :unprocessable_entity, flash: { error: "Failed to create project." }
    end
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to @project, flash: { success: "Project updated successfully!" }
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url, flash: { success: "Project deleted successfully!" }
  end

  private

  def set_project
    @project = current_user.projects.find_by!(token: params[:token])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
