# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ENV['RECAPTCHA_PUBLIC_KEY']  = '6LfPjAQTAAAAAHIcZm6r***************'
ENV['RECAPTCHA_PRIVATE_KEY'] = '6LfPjAQTAAAAALfyn4pu***************'
