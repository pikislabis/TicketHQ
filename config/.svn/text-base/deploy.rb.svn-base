set :application, "TicketHQ"
set :repository,  "https://tickethq.googlecode.com/svn/trunk/"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/maria/Web/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :user, "maria"
set :scm_username, "josparbar"

default_run_options[:pty] = true

#role :app, "echalepienzo.homedns.org"
#role :web, "echalepienzo.homedns.org"
#role :db,  "echalepienzo.homedns.org", :primary => true

role :app, "192.168.1.2"
role :web, "192.168.1.2"
role :db,  "192.168.1.2", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

	[:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
