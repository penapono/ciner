# frozen_string_literal: true
# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

# RVM
require 'capistrano/rvm'

# Capistrano rails
require 'capistrano/rails'

require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'

# Migrates
# require 'capistrano/rails/migrations'

# Assets
# require 'capistrano/rails/assets'

# Includes tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails/tree/master/assets
#   https://github.com/capistrano/rails/tree/master/migrations

# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
