set :port, 22
set :user, 'deployer'
set :deploy_via, :remote_cache
set :use_sudo, false

server '45.79.176.251', user: 'deployer', roles: %w{web app db}, :primary => true

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

set :ssh_options, {
    forward_agent: true,
    auth_methods: %w(password),
    password: 'Youtubechannel2015',
    user: 'deployer',
}

set :rails_env, :production
#set :conditionally_migrate, true    