require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ciner
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.active_record.default_timezone = :local
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = "pt-BR"
    config.time_zone = 'Brasilia'
    config.encoding = "utf-8"
    I18n.config.enforce_available_locales = false
    config.generators.javascript_engine :js

    config.active_record.raise_in_transactional_callbacks = true

    routes = Dir[Rails.root.join("config/routes/*.rb")] + config.paths['config/routes.rb']
    config.paths['config/routes.rb'] = routes
  end
end
