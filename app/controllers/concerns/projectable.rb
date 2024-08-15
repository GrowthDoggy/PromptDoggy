module Projectable
  extend ActiveSupport::Concern

  included do
    before_action :set_project
  end

  private

  def set_project
    project_identifier = params[:project_token] || params[:token]
    @project = current_user.projects.find_by!(token: project_identifier)
  end
end
