# frozen_string_literal: true

module ApplicationHelper
  # Return the full title on a per-pages basis
  def full_title(page_title = '')
    base_title = "CINER"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def add_visit(params, path, current_user = nil)
    user_id = current_user ? current_user.id : ""
    raw("addVisit('#{params[:controller]}','#{params[:action]}', '#{params[:id]}' ,'#{path}', '#{user_id}');")
  end

  def current_role(current_user = nil, url)
    return nil unless current_user
    return :admin if url.include? '/admin'
    :platform
  end
end
