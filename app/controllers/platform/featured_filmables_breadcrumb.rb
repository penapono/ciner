# frozen_string_literal: true

module Platform
  module FeaturedFilmablesBreadcrumb
    include ::BreadcrumbController

    def actions_breadcrumbs
      {
        'index': index_breadcrumbs
      }
    end

    def index_breadcrumbs
      [
        area_breadcrumb,
        ["Destaques", ""]
      ]
    end

    def area_breadcrumb
      [t('home.index.title'), platform_root_path]
    end
  end
end
