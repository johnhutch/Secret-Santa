set :stages, %w(staging production testing)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :sync_directories, []
set :sync_backups, 3