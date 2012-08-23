require 'harvested'
require 'webmock/rspec'
require 'vcr'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require File.expand_path(f) }

VCR.configure do |c|
  c.cassette_library_dir = '.cassettes'
  c.hook_into :webmock
end

FileUtils.rm(Dir["#{VCR.configuration.cassette_library_dir}/*"]) if ENV['VCR_REFRESH'] == 'true'

RSpec.configure do |config|
  config.include HarvestedHelpers

  config.before(:suite) do
    WebMock.allow_net_connect!
    cassette("clean") do
      HarvestedHelpers.clean_remote
    end
  end

  config.before(:each) do
    WebMock.allow_net_connect!
  end

  def cassette(*args)
    VCR.use_cassette(*args) do
      yield
    end
  end
end
