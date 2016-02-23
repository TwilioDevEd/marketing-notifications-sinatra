require 'rspec/core/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

task :createDb, [:username] do |_, args|
  desc 'generate application database'
  sh "psql -c 'create database marketing_notifications;' -U #{args[:username]}"
end

task default: :spec
