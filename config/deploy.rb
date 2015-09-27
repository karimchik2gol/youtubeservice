set :application, 'blog'
set :deploy_to, "/home/deployer/apps/blog"

set :scm, :git
set :scm_passphrase, "Youtubechannel2015"
#set :branch, "master"
set :repo_url, 'https://github.com/karimchik2gol/youtubeservice'

set :user, "deployer"
set :rails_env, "production"


set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :rbenv_type, :deployer
set :rbenv_ruby, '1.9.3-p545'


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