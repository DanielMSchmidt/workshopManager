# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'workshop_manager'
set :repo_url, 'git@github.com:DanielMSchmidt/workshopManager.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/workshop_manager'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/newrelic.yml')
set :rbenv_ruby, File.read('.ruby-version').strip

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "sudo supervisorctl restart workshops:workshops-rails-1"
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :generate_500_html do
    on roles(:web) do |host|
      public_500_html = File.join(release_path, "public/500.html")
      execute :curl, "-k", "http://#{host.hostname}/500", "> #{public_500_html}"
    end
  end

  task :generate_404_html do
    on roles(:web) do |host|
      public_404_html = File.join(release_path, "public/404.html")
      execute :curl, "-k", "http://#{host.hostname}/404", "> #{public_404_html}"
    end
  end

  after "deploy:published", :generate_500_html
  after "deploy:published", :generate_404_html
  after :publishing, :restart
end
