module Projectable
  extend ActiveSupport::Concern

  included do
    before_action :set_project
  end

  private

  def set_project
    project_identifier = params[:token] || params[:project_token]
    @project = current_user.projects.find_by!(token: project_identifier)
  end
end
