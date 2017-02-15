# config valid only for current version of Capistrano
lock "3.7.2"

set :application, "ivc"
set :repo_url, "git@github.com:rmds16/ivc.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/ivc"

set :use_sudo, false

# set :rails_env, "production"

set :deploy_via, :copy

set :linked_files, %w{config/database.yml}

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end

#   # desc "Symlink shared config files"
#   # task :symlink_config_files do
#   # 	on roles(:all) do |host|
#   #     execute "ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
#   #   end
#   # end

#   desc "Precompile assets after deploy"
#   task :precompile_assets do
#   	on roles(:all) do |host|
# 	  execute <<-CMD
# 	    cd #{ current_path } && /usr/local/rvm/bin/rvm default do bundle exec rake assets:precompile RAILS_ENV=production
# 	  CMD
# 	end
#   end

#   desc "Restart applicaiton"
#   task :restart do
#   	on roles(:all) do |host|
#       execute "touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
#     end
#   end
# end

# # after "deploy", "deploy:symlink_config_files"
# after "deploy", "deploy:precompile_assets"
# after "deploy:precompile_assets", "deploy:restart"
# # after "deploy", "deploy:cleanup"