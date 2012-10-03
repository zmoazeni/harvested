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
      if client = harvest.clients.find_or_create_by_name("Frannie's Factory")
        project = harvest.projects.create("name" => "Invoiced Project1", "client_id" => client.id)
      end

      # Delete any existing invoices.
      harvest.invoices.all.each {|i| harvest.invoices.delete(i.id)}

      invoice = Harvest::Invoice.new(
        "subject"              => "Invoice for Frannie's Widgets",
        "client_id"            => client.id,
        "issued_at"            => "2011-03-31",
        "due_at"               => "2011-04-15",
        "due_at_human_format"  => "upon receipt",        
        "currency"             => "United States Dollars - USD",
        "number"               => 1000,
        "notes"                => "Some notes go here",
        "kind"                 => "free_form",
        "state"                => "draft",
        "purchase_order"       => nil,
        "tax"                  => nil,
        "tax2"                 => nil,
        "kind"                 => "free_form",
        "import_hours"         => "no",
        "import_expenses"      => "no",
        "line_items"           => [Harvest::LineItem.new("kind" => "Service", "description" => "One item", "quantity" => 200, "unit_price" => "12.00")]
      )
      invoice = harvest.invoices.create(invoice)

      invoice.due_at.should == invoice.issued_at

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

  it 'allows finding one invoice or all invoices with parameters' do
    cassette('invoice3') do
      if client = harvest.clients.find_or_create_by_name("Frannie's Factory")
        project = harvest.projects.create("name" => "Invoiced Project1", "client_id" => client.id)
      end

      # Delete any existing invoices.
      harvest.invoices.all.each {|i| harvest.invoices.delete(i.id)}

      invoice = Harvest::Invoice.new(
        "subject"              => "Invoice for Frannie's Widgets",
        "client_id"            => client.id,
        "issued_at"            => "2011-03-31",
        "due_at"               => "2011-03-31",
        "due_at_human_format"  => "upon receipt",        
        "currency"             => "United States Dollars - USD",
        "number"               => 1000,
        "notes"                => "Some notes go here",
        "kind"                 => "free_form",
        "state"                => "draft",
        "purchase_order"       => nil,
        "tax"                  => nil,
        "tax2"                 => nil,
        "kind"                 => "free_form",
        "import_hours"         => "no",
        "import_expenses"      => "no",
        "line_items"           => [Harvest::LineItem.new("kind" => "Service", "description" => "One item", "quantity" => 200, "unit_price" => "12.00")]
      )
      invoice = harvest.invoices.create(invoice)

      invoice.subject.should == "Invoice for Frannie's Widgets"
      invoice.amount.should == "2400.0"
      invoice.line_items.size.should == 1
      
      invoice = harvest.invoices.find(invoice.id)
      invoice.subject.should == "Invoice for Frannie's Widgets"
      invoice.amount.should == "2400.0"
      invoice.line_items.size.should == 1

      invoices = harvest.invoices.all
      invoices.count.should == 1

      invoices = harvest.invoices.all(:status => 'draft')
      invoices.count.should == 1

      invoices = harvest.invoices.all(:status => 'closed')
      invoices.count.should == 0

      invoices = harvest.invoices.all(:status => 'draft', :page => 1)
      invoices.count.should == 1

      invoices = harvest.invoices.all(:timeframe => {:from => Date.today, :to => Date.today})
      invoices.count.should == 1

      invoices = harvest.invoices.all(:timeframe => {:from => '19690101', :to => '19690101'})
      invoices.count.should == 0
      
      invoices = harvest.invoices.all(:updated_since => Date.today)
      invoices.count.should == 1

      invoices = harvest.invoices.all(:updated_since => '21121231')
      invoices.count.should == 0

      harvest.invoices.delete(invoice)
      harvest.invoices.all.select {|p| p.number == "1000"}.should == []
    end
  end

  it 'allows downloading of Harvest generated PDF of invoice' do
    cassette('invoice4') do
      if client = harvest.clients.find_or_create_by_name("Frannie's Factory")
        project = harvest.projects.create("name" => "Invoiced Project1", "client_id" => client.id)
      end

      # Delete any existing invoices.
      harvest.invoices.all.each {|i| harvest.invoices.delete(i.id)}

      invoice = Harvest::Invoice.new(
        "subject"              => "Invoice for Frannie's Widgets",
        "client_id"            => client.id,
        "issued_at"            => "2011-03-31",
        "due_at"               => "2011-04-15",
        "due_at_human_format"  => "upon receipt",        
        "currency"             => "United States Dollars - USD",
        "number"               => 1000,
        "notes"                => "Some notes go here",
        "kind"                 => "free_form",
        "state"                => "draft",
        "purchase_order"       => nil,
        "tax"                  => nil,
        "tax2"                 => nil,
        "kind"                 => "free_form",
        "import_hours"         => "no",
        "import_expenses"      => "no",
        "line_items"           => [Harvest::LineItem.new("kind" => "Service", "description" => "One item", "quantity" => 200, "unit_price" => "12.00")]
      )
      invoice = harvest.invoices.create(invoice)

      invoice.subject.should == "Invoice for Frannie's Widgets"
      invoice.amount.should == "2400.0"
      invoice.line_items.size.should == 1

      invoice_file = harvest.invoices.download(invoice)
      File.exists?(invoice_file).should == true

      harvest.invoices.delete(invoice)
      harvest.invoices.all.select {|p| p.number == "1000"}.should == []
    end
  end

  it 'allows custom due at values on invoices' do
    cassette('invoice5') do
      if client = harvest.clients.find_or_create_by_name("Frannie's Factory")
        project = harvest.projects.create("name" => "Invoiced Project1", "client_id" => client.id)
      end
  
      # Delete any existing invoices.
      harvest.invoices.all.each {|i| harvest.invoices.delete(i.id)}

      invoice = Harvest::Invoice.new(
        "subject"              => "Invoice for Frannie's Widgets",
        "client_id"            => client.id,
        "issued_at"            => "2011-03-31",
        "due_at"               => "2011-04-15",
        "due_at_human_format"  => "custom",        
        "currency"             => "United States Dollars - USD",
        "number"               => 1000,
        "notes"                => "Some notes go here",
        "kind"                 => "free_form",
        "state"                => "draft",
        "purchase_order"       => nil,
        "tax"                  => nil,
        "tax2"                 => nil,
        "kind"                 => "free_form",
        "import_hours"         => "no",
        "import_expenses"      => "no",
        "line_items"           => [Harvest::LineItem.new("kind" => "Service", "description" => "One item", "quantity" => 200, "unit_price" => "12.00")]
      )
      invoice = harvest.invoices.create(invoice)

      invoice.due_at.should == '2011-04-15'
  
      harvest.invoices.delete(invoice)
      harvest.invoices.all.select {|p| p.number == "1000"}.should == []
    end
  end

end
