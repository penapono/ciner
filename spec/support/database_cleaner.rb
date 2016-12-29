# frozen_string_literal: true
RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end
  # only for those with JS (Capybara + Poltergeirs) we need
  # the :truncation strategy (multiple threads)
  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def database_cleaner_start
  DatabaseCleaner.start
end

def database_cleaner_clean
  DatabaseCleaner.clean
end
