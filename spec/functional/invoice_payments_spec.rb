require 'spec_helper'

describe 'harvest invoice payments' do
  it 'allows retrieving existing invoice payments' do
    cassette('invoice_payment1') do
      client  = harvest.clients.create(FactoryGirl.attributes_for(:client))
      invoice = harvest.invoices.create(FactoryGirl.attributes_for(:invoice, :client_id => client.id))

      payment       = Harvest::InvoicePayment.new(FactoryGirl.attributes_for(:invoice_payment, :invoice_id => invoice.id, :amount => invoice.amount))
      payment_saved = harvest.invoice_payments.create(payment)

      payment_found = harvest.invoice_payments.find(invoice, payment_saved)

      payment_found.should == payment_saved
    end
  end

  it 'allows adding, and removing invoice payments' do
    cassette('invoice_payment2') do
      client  = harvest.clients.create(FactoryGirl.attributes_for(:client))
      invoice = harvest.invoices.create(FactoryGirl.attributes_for(:invoice, :client_id => client.id, update_line_items: true))

      half_amount = (invoice.amount.to_f / 2)

      payment1 = Harvest::InvoicePayment.new(FactoryGirl.attributes_for(:invoice_payment, :invoice_id => invoice.id, :amount => half_amount))
      payment1 = harvest.invoice_payments.create(payment1)

      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'draft'

      payment2 = Harvest::InvoicePayment.new(FactoryGirl.attributes_for(:invoice_payment, :invoice_id => invoice.id, :amount => half_amount))
      payment2 = harvest.invoice_payments.create(payment2)

      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'paid'

      harvest.invoice_payments.all(invoice).each { |ip| harvest.invoice_payments.delete(ip) }
      harvest.invoice_payments.all(invoice).should be_empty

      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'draft'
    end
  end
end
