Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.whiny_nils = true
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  config.assets.compress = false
  config.assets.debug = false
  config.assets.digest = false
  config.assets.raise_runtime_errors = true

  config.log_formatter = ::Logger::Formatter.new

  # Mailer
  # config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :authentication => :plain,
      :user_name => 'sejaciner@gmail.com',
      :password => 'cinerciner2017'
  }

  config.assets.quiet = true
end
