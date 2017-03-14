# config valid only for current version of Capistrano
# lock "3.7.1"

set :application, "Church"

# 服务器 repository 地址
set :nginx_server_name, 'www.example.com'
set :repo_url, 'file:///home/deploy/repository/Church.git'
set :deploy_to, '/home/deploy/Church'     #部署的位置

set :rbenv_type, :deploy # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.3.3'
set :rbenv_path, '/home/deploy/.rbenv'

# in case you want to set ruby version from the file:
# set :rbenv_ruby, File.read('.ruby-version').strip

set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# https://github.com/seuros/capistrano-puma
set :puma_user, fetch(:user)
set :puma_rackup, -> { File.join(current_path, 'config.ru') }
set :puma_state, "#{shared_path}/tmp/pids/puma_#{fetch(:application)}.state"
set :puma_pid,   "#{shared_path}/tmp/pids/puma_#{fetch(:application)}.pid"

#根据nginx配置链接的sock进行设置，需要唯一 #accept array for multi-bind
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma_#{fetch(:application)}.sock"

set :puma_default_control_app, "unix://#{shared_path}/tmp/sockets/pumactl.sock"
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_#{fetch(:application)}_error.log"
set :puma_error_log, "#{shared_path}/log/puma_#{fetch(:application)}_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, false
set :puma_preload_app, false
set :nginx_use_ssl, false

set :linked_files, fetch(:linked_files, []).push('config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')

namespace :deploy do
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
