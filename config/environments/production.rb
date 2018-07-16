Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.public_file_server.enabled = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.log_level = :debug
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  config.active_record.dump_schema_after_migration = false
  # config.force_ssl = true

  # SMTP settings for gmail
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :authentication => :plain,
      :user_name => 'sejaciner@gmail.com',
      :password => 'cinerciner2017'
  }

  config.public_file_server.headers = {
    'Cache-Control' => "public, s-maxage=#{365.days.to_i}, maxage=#{180.days.to_i}",
    'Expires' => "#{1.year.from_now.to_formatted_s(:rfc822)}"
  }

  config.assets.quiet = true
end
