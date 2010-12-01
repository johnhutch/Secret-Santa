set :user, 'hutch'  # Your dreamhost account's username
set :domain, 'secretsanta_staging.johnhutch.com'  # Dreamhost servername where your account is located 
set :project, 'secretsanta'  # Your application as its called in the repository
set :application, 'secretsanta'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}_staging"  # The standard Dreamhost setup

# version control config
set :scm, 'git'
set :repository,  "git@github.com:johnhutch/Secret-Santa.git "
set :deploy_via, :remote_cache
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

desc "restart override"
task :restart, :roles => :app do  
  run "killall -9 ruby"
  run "touch #{current_path}/tmp/restart.txt"
end

task :after_symlink do
  %w[database.yml].each do |c|
    run "ln -nsf #{shared_path}/system/config/#{c} #{current_path}/config/#{c}"
  end
end