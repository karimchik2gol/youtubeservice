# config valid only for current version of Capistrano
lock '3.4.0'
# Define the name of the application

server '45.79.176.251', user: 'deployer', roles: %w{web app db}, :primary => true

# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/[user name]/[application name].git'
set :application, 'blog'
#set :pty, true
set :deploy_to, "/home/deployer/apps/blog"
#set :deploy_via, :remote_cache
#set :use_sudo, false

set :scm, :git
set :scm_passphrase, "Youtubechannel2015"
#set :branch, "master"
set :repo_url, 'https://github.com/karimchik2gol/testapap'

set :user, "deployer"
set :rails_env, "production"
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets}


# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, {
    forward_agent: true,
    auth_methods: %w(password),
    password: 'Youtubechannel2015',
    user: 'deployer',
}

# Define where to put your application code

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
after "deploy", "deploy:cleanup"
namespace :deploy do
   %w[start stop reload].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_blog #{command}"
      end      
    end
  end

  #after :publishing, :restart
  after :publishing, :restart
end
