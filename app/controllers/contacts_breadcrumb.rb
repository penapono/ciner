# frozen_string_literal: true

module ContactsBreadcrumb
  include ::BreadcrumbController

  def actions_breadcrumbs
    {
      'index': index_breadcrumbs
    }
  end

  def index_breadcrumbs
    [
      area_breadcrumb,
      ["Entre em contato", ""]
    ]
  end

  def area_breadcrumb
    [t('home.index.title'), root_path]
  end
end
