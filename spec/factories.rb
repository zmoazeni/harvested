FactoryGirl.define do
  sequence :name do |n|
    "Joe's Steam Cleaning #{n}"
  end

  sequence :description do |n|
    "Item #{n}"
  end

  sequence :project_name do |n|
    "Joe's Steam Cleaning Project #{n}"
  end

  factory :client, class: Harvest::Client do
    name
    details "Steam Cleaning across the country"
  end

  factory :invoice, class: Harvest::Invoice do
    subject "Invoice for Joe's Stream Cleaning"
    client_id nil
    issued_at "2011-03-31"
    due_at "2011-03-31"
    due_at_human_format "upon receipt"

    currency "United States Dollars - USD"
    sequence(:number)
    notes "Some notes go here"
    period_end "2011-03-31"
    period_start "2011-02-26"
    kind "free_form"
    state "draft"
    purchase_order nil
    tax nil
    tax2 nil
    import_hours "no"
    import_expenses "no"
    line_items { [FactoryGirl.build(:line_item)] }
  end

  factory :line_item, class: Harvest::LineItem do
    kind "Service"
    description
    quantity 200
    unit_price "12.00"
  end

  factory :invoice_payment, class: Harvest::InvoicePayment do
    paid_at Time.now
    amount "0.00"
    notes "Payment received"
  end

  factory :invoice_message, class: Harvest::InvoiceMessage do
    body "The message body goes here"
    recipients "john@example.com, jane@example.com"
    attach_pdf true
    send_me_a_copy true
    include_pay_pal_link true
  end

  factory :project, class: Harvest::Project do
    name { generate(:project_name) }
  end
end
