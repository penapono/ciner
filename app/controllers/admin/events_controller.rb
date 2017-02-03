# frozen_string_literal: true
module Admin
  class EventsController < AdminController
    include Admin::EventsBreadcrumb

    # exposes
    expose(:events) { Event.all }
    expose(:event, attributes: :event_attributes)

    PER_PAGE = 10

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
      admin_event_path(resource)
    end

    def resource_params
      event_params
    end

    def event_params
      params.require(:event).permit(
        :title, :description, :event_date, :start_time, :end_time
      )
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
