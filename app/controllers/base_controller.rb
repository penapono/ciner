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

  FIND_ACTIONS = %i[show edit update destroy].freeze

  BASE_HELPER_METHODS = %i[breadcrumbs javascript stylesheet].freeze

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

    def query
      @results = resource.class.search(nil, params.fetch(:search, ''))
    end

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
      loaded_resource = load_resource(resource, params)
      result = upvotes(loaded_resource)
      update_votes_count
      render_json_result(loaded_resource, result)
    end

    def downvote
      loaded_resource = load_resource(resource, params)
      result = downvotes(loaded_resource)
      update_votes_count
      render_json_result(loaded_resource, result)
    end

    def user_action
      result = manage_user_filmable(params)
      render_json_result_for_action(result)
    end

    def manage_user_filmable(params)
      return '' unless params[:user_id] && params[:filmable_id]

      user_id = params[:user_id]
      filmable_id = params[:filmable_id]
      filmable_type = params[:filmable_type]
      user_action = params[:user_action]

      if user_action == "collection"
        media = begin
                params[:media]
              rescue StandardError
                5
              end
        version = begin
                    params[:version]
                  rescue StandardError
                    5
                  end
        position = begin
                  params[:position]
                rescue StandardError
                  0
                end
        store = params[:store]
        gift = params[:gift]
        price = params[:price]
        begin
          bought = Date.parse(params[:bought])
        rescue StandardError
          bought = Date.today
        end
        isbn = params[:isbn]

        borrowed = params[:borrowed]
        observation = params[:observation]

        user_filmable = UserFilmable.find_or_initialize_by(
          user_id: user_id,
          filmable_id: filmable_id, filmable_type: filmable_type,
          action: user_action, media: media, version: version,
          position: position, store: store, gift: gift, price: price,
          bought: bought, isbn: isbn, borrowed: borrowed,
          observation: observation
        )
        return 'active' if user_filmable.save
      else
        user_filmables = UserFilmable.where(
          user_id: user_id,
          filmable_id: filmable_id, filmable_type: filmable_type
        )

        user_filmables&.each do |user_filmable|
          if user_action == user_filmable.action
            user_filmable.destroy
            return ''
          else
            if (user_action == "watched" && user_filmable.want_to_see?) ||
               (user_action == "want_to_see" && user_filmable.watched?)
              user_filmable.action = user_action
              user_filmable.save
              User.find(user_id).create_trophies(user_action) if user_action == 'watched'
              return 'active'
            end
          end
        end
      end

      UserFilmable.create(
        user_id: user_id,
        filmable_id: filmable_id, filmable_type: filmable_type,
        action: user_action
      )
      User.find(user_id).create_trophies(user_action) if user_action == 'watched'
      'active'
    end

    def playing; end

    def playing_soon; end

    def feaured; end

    def available_netflix; end

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
      format(t(".done"), title: resource_title)
    end

    def full_error_flash
      error = resource.errors.full_messages.join(", ")
      format(t(".fail"), title: resource_title, error: error)
    end

    # Reacting

    def already_liked?(loaded_resource)
      current_user.voted_up_on? loaded_resource
    end

    def already_disliked?(loaded_resource)
      current_user.voted_down_on? loaded_resource
    end

    def upvotes(loaded_resource)
      return (current_user.likes loaded_resource) unless already_liked?(loaded_resource)
      current_user.unlike loaded_resource
    end

    def downvotes(loaded_resource)
      return (current_user.dislikes loaded_resource) unless already_disliked?(loaded_resource)
      current_user.undislike loaded_resource
    end

    def update_votes_count
      resource.update_attribute("likes_count", resource.likes_count)
      resource.update_attribute("dislikes_count", resource.dislikes_count)
    end

    def render_json_success
      render json: { status: 'ok' }
    end

    def render_json_error
      render json: { status: 'error' }
    end

    def render_json_result(loaded_resource, result)
      if result
        render json: { status: 'success',
                       like_count: loaded_resource.likes_count,
                       dislike_count: loaded_resource.dislikes_count,
                       like_icon: loaded_resource.like_icon_class(current_user),
                       dislike_icon: loaded_resource.dislike_icon_class(current_user) }
      else
        render json: { status: 'failure', errors: '' }
      end
    end

    def render_json_result_for_action(result)
      if result
        render json: { status: 'success',
                       watched_str: resource.watched_str,
                       want_to_see_str: resource.want_to_see_str,
                       collection_str: resource.collection_str,
                       favorite_str: resource.favorite_str,
                       like_str: resource.like_str,
                       result_class: result }
      else
        render json: { status: 'failure', errors: '' }
      end
    end

    def has_resource?
      resource&.id
    end

    def load_resource(resource, params)
      resource.class.find(params[:id])
    end
  end

  def find_action?
    FIND_ACTIONS.include?(action_name.to_sym)
  end
end
