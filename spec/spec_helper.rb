require 'harvested'
require 'webmock/rspec'
require 'vcr'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require File.expand_path(f) }

VCR.config do |c|
  c.cassette_library_dir = '.cassettes'
  c.stub_with :webmock
end

RSpec.configure do |config|
  config.before do
    WebMock.allow_net_connect!
  end
  
  config.include HarvestedHelpers
  
  config.before(:suite) do
    WebMock.allow_net_connect!
    VCR.use_cassette("clean", :record => :new_episodes) do
      HarvestedHelpers.clean_remote
    end
  end
  
  config.before do
    connect_to_harvest
  end
  
  # config.before(:each, :remote => true) do
  #   
  # end
  # 
  # config.before(:each, :clean => true) do
  #   VCR.use_cassette("clean") do
  #     connect_to_harvest
  #     begin
  #       clean_remote
  #     rescue => e
  #       p e
  #       p e.response
  #     end
  #   end
  # end
  
end
