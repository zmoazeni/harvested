require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "harvested"
    gem.summary = %Q{A Ruby Wrapper for the Harvest API http://www.getharvest.com/}
    gem.description = %Q{Harvested wraps the Harvest API concisely without the use of Rails dependencies. More information about the Harvest API can be found at http://www.getharvest.com/api}
    gem.email = "zach.moazeni@gmail.com"
    gem.homepage = "http://github.com/zmoazeni/harvested"
    gem.authors = ["Zach Moazeni"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "cucumber", ">= 0"
    gem.add_development_dependency "ruby-debug", ">= 0"
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

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
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
