module SidebarHelper
  def active_link?(controllers: [], actions: [])
    controllers = [controllers] unless controllers.is_a?(Array)
    actions = [actions] unless actions.is_a?(Array)
    controllers.map!(&:to_s)
    actions.map!(&:to_s)
    actions.present? ? controllers.include?(controller_name) && actions.include?(action_name) : controllers.include?(controller_name)
  end
end
