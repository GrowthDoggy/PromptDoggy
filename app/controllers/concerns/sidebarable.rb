module Sidebarable
  extend ActiveSupport::Concern

  included do
    before_action :set_sidebar_partial
  end

  private

  def set_sidebar_partial
    @sidebar_partial = 'projects'
  end
end
