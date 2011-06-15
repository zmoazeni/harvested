require 'spec_helper'

describe Harvest::User do
  it_behaves_like 'a json sanitizer', %w(cache_version)
  
  describe "#timezone" do
    it "should convert friendly timezone setting" do
      p = Harvest::User.new(:timezone => :cst)
      p.timezone.should == 'Central Time (US & Canada)'
      
      p = Harvest::User.new(:timezone => :est)
      p.timezone.should == 'Eastern Time (US & Canada)'
      
      p = Harvest::User.new(:timezone => :mst)
      p.timezone.should == 'Mountain Time (US & Canada)'
      
      p = Harvest::User.new(:timezone => :pst)
      p.timezone.should == 'Pacific Time (US & Canada)'
      
      p = Harvest::User.new(:timezone => 'pst')
      p.timezone.should == 'Pacific Time (US & Canada)'
    end
    
    it "should convert standard zones" do
      p = Harvest::User.new(:timezone => 'america/chicago')
      p.timezone.should == 'Central Time (US & Canada)'
    end
    
    it "should leave literal zones" do
      p = Harvest::User.new(:timezone => 'Central Time (US & Canada)')
      p.timezone.should == 'Central Time (US & Canada)'
    end
  end
end