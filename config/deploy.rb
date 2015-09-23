# config valid only for current version of Capistrano
lock '3.4.0'
# Define the name of the application


# Define where can Capistrano access the source repository
# set :repo_url, 'https://github.com/[user name]/[application name].git'
set :application, 'blog'
set :repo_url, 'https://github.com/karimchik2gol/youtubeservice'
set :scm, :git
set :branch, "master"
set :scm_passphrase, "Youtubechannel2015"

set :deploy_to, "/home/deployer/apps/blog"
set :user, "deployer"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy

set :ssh_options, { :forward_agent => true, :port => 4321 }

# Define server(s)
server '45.79.176.251', user: 'deployer', roles: %w{web app db}, :primary => true

# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, {
    forward_agent: false,
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

namespace :deploy do

  %w[start stop restart].each do |command|
    desc 'Manage Unicorn'
    task command do
      on roles(:app), in: :sequence, wait: 1 do
        execute "/etc/init.d/unicorn_#{fetch(:application)} #{command}"
      end      
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

 
end

 task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"