# config valid only for current version of Capistrano
lock '3.4.0'
# Define the name of the application


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
set :repo_url, 'git@github.com:karimchik2gol/youtubeservice.git'

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


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end