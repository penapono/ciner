# frozen_string_literal: true

module ContractsBreadcrumb
  include ::BreadcrumbController

  def actions_breadcrumbs
    {
      'index': index_breadcrumbs
    }
  end

  def index_breadcrumbs
    [
      area_breadcrumb,
      ["Contrato", ""]
    ]
  end

  def area_breadcrumb
    [t('home.index.title'), root_path]
  end
end
