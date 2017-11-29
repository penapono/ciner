# frozen_string_literal: true

module Admin
  module DelatesBreadcrumb
    include ::BreadcrumbController

    def actions_breadcrumbs
      {
        'index': index_breadcrumbs
      }
    end

    def index_breadcrumbs
      [
        area_breadcrumb,
        ["Denúncias", ""]
      ]
    end

    def area_breadcrumb
      [t('home.index.title'), admin_root_path]
    end
  end
end
