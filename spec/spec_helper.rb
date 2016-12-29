ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, :type => :controller
  config.include Rails.application.routes.url_helpers
  config.include ActionView::Helpers::UrlHelper


  # config for rspec 3
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /bin\//,
    /gems/,
    /spec\/spec_helper\.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/
  ]

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
end

# Comum para todos os testes

# The 'build' methods from FactoryGirl only sets attributes of the model and
# the 'attributes_for' method doesn't build relations declared on factories.
# This helper merges the result of this two FactoryGirl's methods
def build_attributes_for(klass, options = nil)
  attributes_for(klass, options).with_indifferent_access.reverse_merge build(klass, options).attributes
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Choose one or more libraries:
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
