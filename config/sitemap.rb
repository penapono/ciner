require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://ciner.com.br'
SitemapGenerator::Sitemap.create_index = :auto
SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: priority: 0.5, changefreq: 'weekly',
  #           lastmod: Time.now, host: default_host
  #
  # Examples:
  #
  # Add '/movies'
  #
  #   add movies_path, priority: 0.7, changefreq: 'daily'
  #
  # Add all movies:
  #
  #   Movie.find_each do |movie|
  #     add movie_path(movie), lastmod: movie.updated_at
  #   end
  add platform_root_path, changefreq: 'daily'
  add platform_users_path, changefreq: 'daily'
  add platform_studios_path, changefreq: 'daily'
  add platform_professionals_path, changefreq: 'daily'
  add platform_curriculums_path, changefreq: 'daily'
  add platform_notifications_path, changefreq: 'daily'
  add platform_featured_filmables_path, changefreq: 'daily'
  add platform_playing_filmables_path, changefreq: 'daily'
  add platform_movies_path, changefreq: 'daily'
  add platform_series_index_path, changefreq: 'daily'
  add platform_events_path, changefreq: 'daily'
  add platform_critics_path, changefreq: 'daily'
  add platform_questions_path, changefreq: 'daily'
  add platform_broadcasts_path, changefreq: 'daily'
  add root_path, changefreq: 'daily'
  add contract_path, changefreq: 'daily'
  add privacy_path, changefreq: 'daily'
  add mission_path, changefreq: 'daily'
  add merchant_path, changefreq: 'daily'
  add contacts_path, changefreq: 'daily'
  add critics_path, changefreq: 'daily'
  add events_path, changefreq: 'daily'
  add questions_path, changefreq: 'daily'
  add broadcasts_path, changefreq: 'daily'
  add notifications_path, changefreq: 'daily'
  add searches_path, changefreq: 'daily'
  add movies_path, changefreq: 'daily'
  add series_index_path, changefreq: 'daily'
  add professionals_path, changefreq: 'daily'
  add curriculums_path, changefreq: 'daily'
  add users_path, changefreq: 'daily'

  Movie.current_playing.find_each do |movie|
    add movie_path(movie), lastmod: movie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Movie.playing_soon.find_each do |movie|
    add movie_path(movie), lastmod: movie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Movie.featured.find_each do |movie|
    add movie_path(movie), lastmod: movie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Movie.available_netflix.find_each do |movie|
    add movie_path(movie), lastmod: movie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Serie.current_playing.find_each do |serie|
    add series_path(serie), lastmod: serie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Serie.playing_soon.find_each do |serie|
    add series_path(serie), lastmod: serie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Serie.featured.find_each do |serie|
    add series_path(serie), lastmod: serie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Serie.available_netflix.find_each do |serie|
    add series_path(serie), lastmod: serie.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Professional.featured.find_each do |professional|
    add professional_path(professional), lastmod: professional.updated_at, priority: 0.7, changefreq: 'daily'
  end

  Curriculum.find_each do |curriculum|
    add curriculum_path(curriculum), lastmod: curriculum.updated_at, changefreq: 'daily'
  end

  Critic.find_each do |critic|
    add critic_path(critic), lastmod: critic.updated_at, changefreq: 'daily'
  end

  Event.find_each do |event|
    add event_path(event), lastmod: event.updated_at, changefreq: 'daily'
  end

  Question.find_each do |question|
    add question_path(question), lastmod: question.updated_at, changefreq: 'daily'
  end

  User.find_each do |user|
    add user_path(user), lastmod: user.updated_at, changefreq: 'daily'
  end
end
