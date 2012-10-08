require 'spec_helper'

describe Harvest::Expense do
  it_behaves_like 'a json sanitizer', %w(has_receipt receipt_url)
  
  describe "#spent_at" do
    it "should parse strings" do
      date = RUBY_VERSION =~ /1.8/ ? "12/01/2009" : "01/12/2009"
      expense = Harvest::Expense.new(:spent_at => date)
      expense.spent_at.should == Date.parse(date)
    end
    
    it "should accept times" do
      expense = Harvest::Expense.new(:spent_at => Time.utc(2009, 12, 1))
      expense.spent_at.should == Date.new(2009, 12, 1)
    end
  end
end
