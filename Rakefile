require 'rspec/core/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

task :createDb, [:username] do |t, args|
   sh "psql -c 'create database testando_task;' -U #{args[:username]}"
end

task :default => :spec
