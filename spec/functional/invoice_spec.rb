require 'spec_helper'

describe 'harvest invoices' do
  it 'allows adding, updating and removing categories' do
    cassette('invoice1') do
      cat = harvest.invoice_categories.create("name" => "New Category")
      cat.name.should == "New Category"
      
      cat.name = "Updated Category"
      cat = harvest.invoice_categories.update(cat)
      cat.name.should == "Updated Category"
      
      harvest.invoice_categories.delete(cat)
      harvest.invoice_categories.all.select {|c| c.name == "Updated Category" }.should == []
    end
  end
  
  it 'allows adding, updating and removing invoices' do
    cassette('invoice2') do
      client  = harvest.clients.create("name" => "Frannie's Factory")
      project = harvest.projects.create("name" => "Invoiced Project1", "client_id" => client.id)
      
      # invoice        = harvest.invoices.create(
      invoice = Harvest::Invoice.new(
        "subject"    => "Invoice for Frannie's Widgets",
        "client_id"  => client.id,
        "issued_at" => "2008-02-06",
        "due_at" => "2008-02-06",
        "due_at_human_format" => "upon receipt",
        
        "currency" => "United States Dollars - USD",
        "number"     => 1000,
        "notes" => "Some notes go here",
        "period_end" => "2008-03-31",
        "period_start" => "2007-06-26",
        "state" => "draft",
        "purchase_order" => nil,
        "tax" => nil,
        "tax2" => nil,
        "kind" => "free_form",
        "import_hours" => "no",
        "import_expenses" => "no"
        # "line_items" => [Harvest::LineItem.new("kind" => "Service", "description" => "One item", "quantity" => 200, "unit_price" => "12.00")]
      )
      p invoice.to_json
      invoice = harvest.invoices.create(invoice)
      
      invoice.subject.should == "Invoice for Frannie's Widgets"
      invoice.amount.should == "2400.0"
      invoice.line_items.size.should == 1
      
      invoice.subject    = "Updated Invoice for Frannie"
      invoice.line_items << Harvest::LineItem.new("kind" => "Service", "description" => "Two item", "quantity" => 10, "unit_price" => "2.00", "amount" => "20.0")
      
      invoice = harvest.invoices.update(invoice)
      invoice.subject.should == "Updated Invoice for Frannie"
      invoice.amount.should == "2420.0"
      invoice.line_items.size.should == 2
  
      harvest.invoices.delete(invoice)
      harvest.invoices.all.select {|p| p.number == "1000"}.should == []
    end
  end
end
