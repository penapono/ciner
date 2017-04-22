# frozen_string_literal: true

module UserActionable
  extend ActiveSupport::Concern

  included do
    def watched_count
      UserFilmable.watched.where(filmable: self).count
    end

    def want_to_see_count
      UserFilmable.want_to_see.where(filmable: self).count
    end

    def collection_count
      UserFilmable.collection.where(filmable: self).count
    end

    def favorite_count
      UserFilmable.favorite.where(filmable: self).count
    end

    def like_count
      UserFilmable.like.where(filmable: self).count
    end

    def watched_str
      return "1 assistiu" if watched_count == 1
      "#{watched_count} assistiram"
    end

    def want_to_see_str
      return "1 quer ver" if want_to_see_count == 1
      "#{want_to_see_count} querem ver"
    end

    def collection_str
      return "1 tem na coleção" if collection_count == 1
      "#{collection_count} tem na coleção"
    end

    def favorite_str
      return "1 favoritou" if favorite_count == 1
      "#{favorite_count} favoritaram"
    end

    def like_str
      return "1 indica" if like_count == 1
      "#{like_count} indicam"
    end
  end
end
