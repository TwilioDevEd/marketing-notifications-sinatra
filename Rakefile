require 'rspec/core/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

task :createDb do
  sh "psql -c 'create database marketing_notifications;' -U postgres" 
end

task :default => :spec
