require 'harvested'
require 'webmock/rspec'
require 'vcr'
require 'factory_girl'
require 'byebug'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require File.expand_path(f) }

VCR.configure do |c|
  c.cassette_library_dir = '.cassettes'
  c.hook_into :webmock

  c.default_cassette_options = {
    # force cassettes to re_record when we pass VCR_REFRESH=true
    re_record_interval: ENV['VCR_REFRESH'] == 'true' ? 0 : nil
  }
  c.allow_http_connections_when_no_cassette = true
end

FactoryGirl.find_definitions

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
    if ENV['USE_VCR']
      VCR.use_cassette(*args) do
        yield
      end
    else
      yield
    end
  end
end
