require "#{Dir.pwd}/lib/tasks/db/seed.rb"
class HuApi < Thor
  include Thor::Actions
  include Thor::Rails

  desc 'build', 'Build project from scratch'
  def build
    run('bundle install', verbose: false)
    run('bundle exec rake db:create', verbose: false)
    run('bundle exec rake db:migrate', verbose: false)
  end

  desc 'rebuild', 'Rebuild project from scratch'
  def rebuild
    run('bundle install', verbose: false)
    run('bundle exec rake db:drop', verbose: false)
    run('bundle exec rake db:create', verbose: false)
    run('bundle exec rake db:migrate', verbose: false)
  end

  desc 'rebuild', 'Rebuild project from scratch loading seed'
  def rebuild_with_seed
    rebuild
    args = []
    options = {
    hotel_file: "../artefatos/hoteis.txt",
    availability_file: "../artefatos/disp.txt"
    }
    tasks = Db::Seed.new(args, options)
    tasks.invoke('db:seed:hotels')
    tasks.invoke('db:seed:availabilities')
  end

end