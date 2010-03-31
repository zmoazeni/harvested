require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::Person do
  describe "#timezone" do
    it "should convert friendly timezone setting" do
      p = Harvest::Person.new(:timezone => :cst)
      p.timezone.should == 'Central Time (US & Canada)'
      
      p = Harvest::Person.new(:timezone => :est)
      p.timezone.should == 'Eastern Time (US & Canada)'
      
      p = Harvest::Person.new(:timezone => :mst)
      p.timezone.should == 'Mountain Time (US & Canada)'
      
      p = Harvest::Person.new(:timezone => :pst)
      p.timezone.should == 'Pacific Time (US & Canada)'
      
      p = Harvest::Person.new(:timezone => 'pst')
      p.timezone.should == 'Pacific Time (US & Canada)'
    end
    
    it "should convert standard zones" do
      p = Harvest::Person.new(:timezone => 'america/chicago')
      p.timezone.should == 'Central Time (US & Canada)'
    end
    
    it "should leave literal zones" do
      p = Harvest::Person.new(:timezone => 'Central Time (US & Canada)')
      p.timezone.should == 'Central Time (US & Canada)'
    end
  end
end