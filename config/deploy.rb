# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'blog'
set :repo_url, 'https://github.com/karimchik2gol/youtubeservice'

set :branch, "master"

set :use_sudo, false
set :bundle_binstubs, nil
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do
  task :restart do
    invoke 'unicorn:reload'
  end
end