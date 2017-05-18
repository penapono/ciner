# frozen_string_literal: true

module UserActionsHelper
  def user_action_class_on(user, object, user_action)
    return '' unless user
    user_filmable =
      UserFilmable.find_by(user_id: user.id,
                           filmable_id: object.id,
                           filmable_type: object.class,
                           action: user_action.to_sym)

    user_filmable.blank? ? '' : 'active'
  end

  def user_action_on(user, object, user_action)
    return '' unless user
    user_filmable =
      UserFilmable.find_by(user_id: user.id,
                           filmable_id: object.id,
                           filmable_type: object.class,
                           action: user_action.to_sym)

    user_filmable
  end

  def watched_count_for_user(user)
    UserFilmable.watched.where(user: user).count
  end

  def want_to_see_count_for_user(user)
    UserFilmable.want_to_see.where(user: user).count
  end

  def collection_count_for_user(user)
    UserFilmable.collection.where(user: user).count
  end

  def favorite_count_for_user(user)
    UserFilmable.favorite.where(user: user).count
  end

  def like_count_for_user(user)
    UserFilmable.like.where(user: user).count
  end
end
