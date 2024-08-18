class Api::V1::PromptsController < Api::BaseController
  before_action :authenticate_with_api_key!

  before_action :set_project
  before_action :set_environment


  def index
    @prompts = @project.prompts

    # Add a conditional to filter prompts by the is_static parameter.
    if params[:is_static].present?
      is_static = ActiveModel::Type::Boolean.new.cast(params[:is_static])
      @prompts = @prompts.last_static_deployment(is_static)
    end

    # Add a conditional to filter prompts by the is_deployed parameter.
    if params[:is_deployed].present?
      if ActiveModel::Type::Boolean.new.cast(params[:is_deployed])
        @prompts = @prompts.joins(:deployments)
                           .where(deployments: { environment_id: @environment.id })
      end
    end

    render json: @prompts.distinct
  end

  def show
    @prompt = @project.prompts.joins(:deployments)
                      .where(deployments: { environment_id: @environment.id })
                      .find_by!(name: params[:name])

    render json: @prompt
  end

  private

  def set_project
    @project = @current_user.projects.find_by!(token: params[:project_token])
  end

  def set_environment
    @environment = @project.environments.find_by!(token: params[:environment_token])
  end
end
