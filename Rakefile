require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "harvested"
    gem.summary = %Q{A Ruby Wrapper for the Harvest API http://www.getharvest.com/}
    gem.description = %Q{Harvested wraps the Harvest API concisely without the use of Rails dependencies. More information about the Harvest API can be found on their website (http://www.getharvest.com/api). For support hit up the Mailing List (http://groups.google.com/group/harvested)}
    gem.email = "zach.moazeni@gmail.com"
    gem.homepage = "http://github.com/zmoazeni/harvested"
    gem.authors = ["Zach Moazeni"]
    gem.add_development_dependency "rspec", ">= 2.0"
    gem.add_development_dependency "cucumber", ">= 0"
    #gem.add_development_dependency "ruby-debug19", ">= 0"
    #gem.add_development_dependency "ruby-debug", ">= 0"
    gem.add_development_dependency "fakeweb", ">= 0"
    gem.add_dependency "httparty", ">= 0"
    gem.add_dependency "happymapper", ">= 0"
    gem.add_dependency "builder", ">= 0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError => e
  p e
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
#  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
#  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

begin
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)

  task :features => :check_dependencies
rescue LoadError
  task :features do
    abort "Cucumber is not available. In order to run features, you must: sudo gem install cucumber"
  end
end

task :default => %w(spec features)

begin
  require 'yard'
  YARD::Rake::YardocTask.new
rescue LoadError
  task :yardoc do
    abort "YARD is not available. In order to run yardoc, you must: sudo gem install yard"
  end
end
