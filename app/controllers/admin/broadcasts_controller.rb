# frozen_string_literal: true

module Admin
  class BroadcastsController < AdminController
    include Admin::BroadcastsBreadcrumb

    PER_PAGE = 10

    PERMITTED_PARAMS = [
      :title, :content, :spoiler, :featured,
      :cover, :more, :video, :broadcast_date,
      :subtitle, :source,
      :movie_content, :serie_content, :celebrity_content,
      broadcast_broadcastables_attributes: %i[
        broadcastable_id
        broadcastable_type
        broadcast_id
        id
        _destroy
      ],
      broadcast_images_attributes: %i[
        media
        broadcast_id
        id
        _destroy
      ]
    ].freeze

    # exposes
    expose(:broadcasts) { Broadcast.all_creation }
    expose(:broadcast, attributes: :broadcast_attributes)

    def index
      self.broadcasts = paginated_broadcasts
    end

    private

    def resource
      broadcast
    end

    def resource_title
      broadcast.title
    end

    def index_path
      admin_broadcasts_path
    end

    def show_path
      admin_broadcasts_path
    end

    def resource_params
      broadcast_params
    end

    def broadcast_params
      params.require(:broadcast).permit(PERMITTED_PARAMS)
    end

    # Filtering

    def paginated_broadcasts
      filtered_broadcast.page(params[:page]).per(PER_PAGE)
    end

    def filtered_broadcast
      broadcasts.filter_by(searched_broadcasts, params.fetch(:filter, ''))
    end

    def searched_broadcasts
      broadcasts.search(nil, params.fetch(:search, ''))
    end
  end
end
