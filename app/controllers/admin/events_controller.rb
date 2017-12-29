# frozen_string_literal: true

module Admin
  class EventsController < AdminController
    include Admin::EventsBreadcrumb

    PER_PAGE = 20

    PERMITTED_PARAMS = [
      :state_id,
      :place,
      :title,
      :subtitle,
      :description,
      :event_date,
      :end_date,
      :start_time,
      :end_time,
      :video,
      :more,
      :cover,
      :featured,
      :event_images_attributes,
      event_images_attributes: %i[
        media
        event_id
        id
        _destroy
      ]
    ].freeze

    # exposes
    expose(:events) { Event.includes(:state).includes(:event_images).order(event_date: :asc) }
    expose(:event, attributes: :event_attributes)

    def index
      self.events = paginated_events
    end

    private

    def resource
      event
    end

    def resource_title
      event.title
    end

    def index_path
      admin_events_path
    end

    def show_path
      admin_events_path
    end

    def resource_params
      event_params
    end

    def event_params
      params.require(:event).permit(PERMITTED_PARAMS)
    end

    # Filtering

    def paginated_events
      filtered_event.page(params[:page]).per(PER_PAGE)
    end

    def filtered_event
      events.filter_by(searched_events, params.fetch(:filter, ''))
    end

    def searched_events
      events.search(current_user, params.fetch(:search, ''))
    end
  end
end
