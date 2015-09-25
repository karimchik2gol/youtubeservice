root="/home/deployer/apps/blog/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/myunicorn.log"
stdout_path "#{root}/log/myunicorn.log"

listen "/tmp/unicorn.blog.sock"
worker_processes 2
timeout 30

# set path to application
app_dir = "/home/deployer/apps/blog/current"
shared_dir = "#{app_dir}/shared"
working_directory app_dir


# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Set up socket location
listen "#{shared_dir}/sockets/unicorn.sock", :backlog => 64

# Logging
stderr_path "#{shared_dir}/log/myunicorn.stderr.log"
stdout_path "#{shared_dir}/log/myunicorn.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/unicorn.pid"