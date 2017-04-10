# frozen_string_literal: true
module HeaderHelper
  def active_menu_class(controller)
    pages = [controller.to_s, "admin/#{controller}", "platform/#{controller}"]

    klass = (pages.include? controller_path) ? "active" : ""

    klass
  end
end
