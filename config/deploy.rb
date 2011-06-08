set :application, "cdn"
set :repository,  "git@git01.phpfog.com:oommgg.phpfogapp.com"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :deploy_to, "/var/www/html/deploy"
set :user, "root"

role :web, "develope"                          # Your HTTP server, Apache/etc
role :app, "develope"                          # This may be the same as your `Web` server
role :db,  "develope", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :keep_releases, 5
set :deploy_via, :remote_cache


# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

# namespace :deploy do
#   task :start {}
#   task :stop {}
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


namespace :deploy do
    desc "start"
    task :start do
    end

    desc "restart"
    task :restart do
    end

    desc "stop"
    task :stop do
    end

    desc "customize the finalize update task"
    task :finalize_update, :except => { :no_release => true } do
        run "chmod -R g+w #{latest_release}"
        if fetch(:group_writeable, true)
            run "rm -rf #{latest_release}/logs"
            run "mkdir -p #{shared_path}/log"
            run "ln -s #{shared_path}/log #{latest_release}/logs"
            run "chmod -R 777 #{latest_release}/logs"
            run "rm -rf #{latest_release}/tpl"
            run "mkdir -p #{shared_path}/tpl"
            run "ln -s #{shared_path}/tpl #{latest_release}/tpl"
            run "chmod -R 777 #{latest_release}/tpl"
        end

    end
    
    desc "overwrite deploy:cold"
    task :cold do
        update
        start
    end


end
