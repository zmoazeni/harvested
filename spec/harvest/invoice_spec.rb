require 'spec_helper'

describe Harvest::Invoice do
  context 'line_items' do
    it 'parses csv into objects' do
      invoice = Harvest::Invoice.new(:line_items => "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,100\nService,def,1.00,20.00,20.0,false,false,101\n")
      invoice.line_items.count.should == 2
      line_item = invoice.line_items.first
      
      line_item.kind.should == "Service"
      line_item.project_id.should == "100"
    end
    
    it 'parses csv into objects w/o projects' do
      invoice = Harvest::Invoice.new(:line_items => "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,\nService,def,1.00,20.00,20.0,false,false,\n")
      invoice.line_items.count.should == 2
      line_item = invoice.line_items.first
      
      line_item.kind.should == "Service"
      line_item.description.should == "Abc"
    end
    
    it 'parses empty strings' do
      invoice = Harvest::Invoice.new(:line_items => "")
      invoice.line_items.should == []
    end
    
    it 'accepts rich objects' do
      Harvest::Invoice.new(:line_items => [Harvest::LineItem.new(:kind => "Service")]).line_items.count.should == 1
      Harvest::Invoice.new(:line_items => Harvest::LineItem.new(:kind => "Service")).line_items.count.should == 1
    end
    
    it 'accepts nil' do
      Harvest::Invoice.new(:line_items => nil).line_items.should == []
    end
  end
  
  context "as_json" do
    it 'encodes line items csv' do
      invoice = Harvest::Invoice.new(:line_items => "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,\nService,def,1.00,20.00,20.0,false,false,\n")
      invoice.line_items.count.should == 2
      invoice.line_items.first.kind.should == "Service"
      
      invoice.as_json["invoice"]["csv_line_items"].should == "kind,description,quantity,unit_price,amount,taxed,taxed2,project_id\nService,Abc,200,12.00,2400.0,false,false,\nService,def,1.00,20.00,20.0,false,false,\n"
    end
  end
end