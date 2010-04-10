require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Harvest::Expense do
  describe "#spent_at" do
    it "should parse strings" do
      expense = Harvest::Expense.new(:spent_at => "12/01/2009")
      expense.spent_at.should == Time.parse("12/01/2009")
    end
    
    it "should accept times" do
      expense = Harvest::Expense.new(:spent_at => Time.parse("12/01/2009"))
      expense.spent_at.should == Time.parse("12/01/2009")
    end
  end
end
