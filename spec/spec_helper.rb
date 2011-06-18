require 'harvested'
require 'webmock/rspec'
require 'vcr'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require File.expand_path(f) }

VCR.config do |c|
  c.cassette_library_dir = '.cassettes'
  c.stub_with :webmock
end

RSpec.configure do |config|
  config.include HarvestedHelpers
  
  config.before(:suite) do
    WebMock.allow_net_connect!
    cassette("clean") do
      HarvestedHelpers.clean_remote
    end
  end
  
  def cassette(*args)
    if ENV['CACHE'] == "false"
      if args.last.is_a?(Hash)
        last = args.pop
        last[:record] = :all
        args << last
      else
        args << {:record => :all}
      end
    end
    
    VCR.use_cassette(*args) do
      yield
    end
  end
end
