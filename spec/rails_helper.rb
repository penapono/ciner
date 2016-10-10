# XXX this must stay in the beginning of the file!
# coverage report generated only with COVERAGE env variable set
if ENV['COVERAGE']
  require 'simplecov'
  require 'simplecov-rcov'
  require 'codeclimate-test-reporter'

  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.start(:rails)
  CodeClimate::TestReporter.start
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# Remove comment to test locales
# I18n.exception_handler = TestExceptionLocalizationHandler.new

require "shoulda/matchers"
::Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec
    # with.test_framework :minitest
    # with.test_framework :minitest_4
    # with.test_framework :test_unit

    # Choose one or more libraries:
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

RSpec.configure do |config|
  config.before(type: :controller) do
    request.env['HTTP_REFERER'] = '/'
  end

  config.infer_spec_type_from_file_location!

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Enabling FactoryGirl methods with ease
  config.include FactoryGirl::Syntax::Methods

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Raises error on deprecated tests
  # config.raise_errors_for_deprecations!

  # Devise
  config.include Devise::TestHelpers, type: :controller
  config.include Devise::TestHelpers, type: :helper

  # force spec_helper to read all uploaders
  Dir["#{Rails.root}/app/uploaders/*.rb"].each { |file| require file }
  if defined?(CarrierWave)
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?

      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/cache"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/" \
          "#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  # delete all uploaded files after specs run
  config.after(:all) do
    if Rails.env.test?
      FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
    end
  end
end
