# frozen_string_literal: true

module Api::V1::BaseController
  extend ActiveSupport::Concern

  # def resource
  #   model
  # end

  included do
    def new
      render layout: false
    end

    def create
      if created?
        create_render_success
      else
        create_render_error
      end
    end

    private

    # custom actions

    def created?
      resource.save
    end

    # action responses
    def create_render_success
      render status: :created, json: {}
    end

    def create_render_error
      render status: :unprocessable_entity, json: { errors: errors_to_render }
    end

    # error handler
    def errors_to_render
      resource.errors.each_with_object({}) do |(k, v), errors|
        errors[resource.class.human_attribute_name(k)] = v
      end
    end
  end
end
