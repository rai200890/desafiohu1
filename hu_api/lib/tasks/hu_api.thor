require 'thor/rails'
require_relative "db/seed.rb"
class HuApi < Thor
  include Thor::Actions
  include Thor::Rails

  desc 'build', 'Build project from scratch'
  def build
    run('bundle exec rake db:create', verbose: false)
    run('bundle exec rake db:migrate', verbose: false)
  end

  desc 'rebuild', 'Rebuild project from scratch'
  def rebuild
    run('bundle exec rake db:drop', verbose: false)
    run('bundle exec rake db:create', verbose: false)
    run('bundle exec rake db:migrate', verbose: false)
  end

  desc 'build', 'Build project from scratch loading seed'
  def build_with_seed
    build
    args = []
    options = {
        hotel_file: "../artefatos/hoteis.txt",
        availability_file: "../artefatos/disp.txt"
    }
    tasks = Db::Seed.new(args, options)
    tasks.invoke('db:seed:hotels')
    tasks.invoke('db:seed:availabilities')
  end

  desc 'serve', 'Build project from scratch loading seed and run server'
  def serve
    build_with_seed
    run('rails s Puma -d -p 3000', verbose: false)
  end

end


