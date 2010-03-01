require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Harvest::Models::Client do
  describe ".parse" do
    it "should parse standard xml" do
      clients  = Harvest::Models::Client.parse(File.read("#{File.dirname(__FILE__)}/../../fixtures/client.xml"))
      client = clients.first
      client.id.should == 11072
      client.name.should == "SuprCorp"
      client.active.should be_true
      client.details.should match(/Third Floor/i)
      client.cache_version.should == 1
      client.currency.should match(/United States/i)
      client.currency_symbol.should == "$"
      client.updated_at.should be_close(Time.utc(2009, 12, 10), 86400)
    end
  end
end
