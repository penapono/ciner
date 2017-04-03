# frozen_string_literal: true
module HeaderHelper
  def active_menu_class(controller)
    pages = ["#{controller}", "admin/#{controller}", "platform/#{controller}"]

    (pages.include? controller_path) ? "active" : ""
  end
end
