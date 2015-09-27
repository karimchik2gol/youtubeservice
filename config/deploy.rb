set :application, 'blog'
set :repo_url, 'git@github.com:karimchik2gol/youtubeservice.git'

set :deploy_to, '/home/deployer/apps'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

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