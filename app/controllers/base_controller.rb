# frozen_string_literal: true
module ::BaseController
  extend ActiveSupport::Concern

  # def resource
  # end

  # def resource_title
  # end

  # def index_path
  # end

  # def show_path
  # end

  FIND_ACTIONS = [:show, :edit, :update, :destroy].freeze

  BASE_HELPER_METHODS = [:breadcrumbs, :javascript, :stylesheet].freeze

  included do
    helper_method BASE_HELPER_METHODS

    # helper methods

    def javascript
      "views/#{controller_path}/#{action_name}"
    end

    def stylesheet
      "views/#{controller_path}/#{action_name}"
    end

    def index; end

    def new; end

    def create
      if created?
        redirect_to_index_with_success
      else
        render_new_with_error
      end
    end

    def show; end

    def edit; end

    def update
      if updated?
        redirect_to_show_with_success
      else
        render_edit_with_error
      end
    end

    def destroy
      if destroyed?
        redirect_to_index_with_success
      else
        redirect_to_index_with_error
      end
    end

    def upvote
      result = upvotes(resource)
      update_votes_count
      render_json_result(result)
    end

    def downvote
      result = downvotes(resource)
      update_votes_count
      render_json_result(result)
    end

    private

    # custom actions

    def created?
      resource.save
    end

    def updated?
      resource.update(resource_params)
    end

    def destroyed?
      resource.destroy
    end

    def redirect_to_index_with_success
      redirect_to index_path, notice: full_success_flash
    end

    def redirect_to_show_with_success
      redirect_to show_path, notice: full_success_flash
    end

    def redirect_to_index_with_error
      redirect_to index_path, alert: full_error_flash
    end

    def render_new_with_error
      flash.now[:alert] = full_error_flash
      render :new
    end

    def render_edit_with_error
      flash.now[:alert] = full_error_flash
      render :edit
    end

    def full_success_flash
      (t(".done") % { title: resource_title })
    end

    def full_error_flash
      error = resource.errors.full_messages.join(", ")
      (t(".fail") % { title: resource_title, error: error })
    end

    # Reacting

    def already_liked?
      current_user.voted_up_on? resource
    end

    def already_disliked?
      current_user.voted_down_on? resource
    end

    def upvotes(resource)
      resource = load_resource(resource, params) unless has_resource?
      return (current_user.likes resource) unless already_liked?
      current_user.unlike resource
    end

    def downvotes(resource)
      resource = load_resource(resource, params) unless has_resource?
      return (current_user.dislikes resource) unless already_disliked?
      current_user.undislike resource
    end

    def update_votes_count
      resource.update_attribute("likes_count", resource.likes_count)
      resource.update_attribute("dislikes_count", resource.dislikes_count)
    end

    def render_json_result(result)
      if result
        render json: { status: 'success',
                       like_count: resource.likes_count,
                       dislike_count: resource.dislikes_count,
                       like_icon: resource.like_icon_class(current_user),
                       dislike_icon: resource.dislike_icon_class(current_user) }
      else
        render json: { status: 'failure', errors: critic.errors }
      end
    end

    def has_resource?
      resource && resource.id
    end

    def load_resource(resource, params)
      resource.class.find(params[:id])
    end
  end

  def find_action?
    FIND_ACTIONS.include?(action_name.to_sym)
  end
end
