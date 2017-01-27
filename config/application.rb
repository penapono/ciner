require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ciner
  class Application < Rails::Application
    # Carrega os arquivos de rotas separados em config/routes
    routes = Dir[Rails.root.join("config/routes/*.rb")] + config.paths['config/routes.rb']
    config.paths['config/routes.rb'] = routes

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)

    config.time_zone = 'Brasilia'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = "pt-BR"
    config.encoding = "utf-8"
    config.assets.enabled = true
    config.assets.version = '1.0'

    # Destivar wrap de campos com erros
    config.action_view.field_error_proc = Proc.new { |html_tag, instance|
      "#{html_tag}".html_safe
    }

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.test_framework :rspec
    end

    # This will route any exceptions caught to your router Rack app
    config.exceptions_app = self.routes
  end
end
