# frozen_string_literal: true

module TrendingTrailersBreadcrumb
  include ::BreadcrumbController

  def actions_breadcrumbs
    {
      'index': index_breadcrumbs,
      'new': new_create_breadcrumbs,
      'create': new_create_breadcrumbs,
      'show': show_edit_update_breadcrumbs,
      'edit': show_edit_update_breadcrumbs,
      'update': show_edit_update_breadcrumbs
    }
  end

  def index_breadcrumbs
    [
      area_breadcrumb,
      [TrendingTrailer.model_name.human(count: 2), ""]
    ]
  end

  def new_create_breadcrumbs
    [
      area_breadcrumb,
      index_breadcrumb,
      [t(".title"), ""]
    ]
  end

  def show_edit_update_breadcrumbs
    return unless resource?

    [
      area_breadcrumb,
      index_breadcrumb,
      [trending_trailer.title, ""]
    ]
  end

  def area_breadcrumb
    [t('home.index.title'), root_path]
  end

  def index_breadcrumb
    [TrendingTrailer.model_name.human(count: 2), trending_trailers_path]
  end
end
