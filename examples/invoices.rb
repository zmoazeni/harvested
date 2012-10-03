require "harvested"

subdomain = 'yoursubdomain'
username = 'yourusername'
password = 'yourpassword'

harvest = Harvest.hardy_client(subdomain, username, password)

# Print out all invoices on the account
puts "Invoices:"
harvest.invoices.all.each {|i| p i }

# Create a Client and add an invoice to that Client
client  = harvest.clients.find_or_create_by_name("SuprCorp")

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
