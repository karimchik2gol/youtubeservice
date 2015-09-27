require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano3/ubuntu-server-prepare'
require 'capistrano3/unicorn'
require 'capistrano3/git-push'
require 'capistrano/rvm'
require 'capistrano/bundler'
require 'capistrano/rails'
# Include tasks from other gems included in y
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
