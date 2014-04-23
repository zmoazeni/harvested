require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task :default => %w(spec)

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end

desc 'Removes all data on harvest'
task 'clean_remote' do
  require 'harvested'
  require File.expand_path('../spec/support/harvested_helpers', __FILE__)
  HarvestedHelpers.clean_remote
end
