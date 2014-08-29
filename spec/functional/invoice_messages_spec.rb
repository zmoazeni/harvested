require 'spec_helper'

describe 'harvest invoice messages' do
  it 'allows adding/removing messages to invoice and retrieving existing invoice messages' do
    # Make sure Reminder Message is turned off for this test to pass

    cassette('invoice_message1') do
      # create a new client and invoice
      client = harvest.clients.create(FactoryGirl.attributes_for(:client))
      invoice = harvest.invoices.create(FactoryGirl.attributes_for(:invoice, :client_id => client.id, :issued_at => Date.today - 2, :due_at_human_format => 'NET 30'))

      # add a message to the invoice
      message = Harvest::InvoiceMessage.new(FactoryGirl.attributes_for(:invoice_message,
                                                                       :invoice_id => invoice.id,
                                                                       :body => "A message body"))
      message_saved = harvest.invoice_messages.create(message)

      # retrieve the created invoice and compare
      message_found = harvest.invoice_messages.find(invoice, message_saved)
      message_found.should == message_saved

      # add another message to the invoice
      message2 = Harvest::InvoiceMessage.new(FactoryGirl.attributes_for(:invoice_message,
                                                                        :invoice_id => invoice.id,
                                                                        :body => "Another message body"))
      message2_saved = harvest.invoice_messages.create(message2)

      # get all the messages and test if our 2 saved messages are included
      messages = harvest.invoice_messages.all(invoice)
      messages.should include(message_saved)
      messages.should include(message2_saved)

      # remove a message
      harvest.invoice_messages.delete(message_saved)
      messages = harvest.invoice_messages.all(invoice)
      messages.should_not include(message_saved)
      messages.should include(message2_saved)

      # remove another message
      harvest.invoice_messages.delete(message2_saved)
      messages = harvest.invoice_messages.all(invoice)
      messages.should_not include(message_saved)
      messages.should_not include(message2_saved)

      harvest.invoice_messages.all(invoice).should be_empty
    end
  end

  it 'allows to change the state of an invoice' do
    cassette('invoice_message2') do
      # create a new client and invoice
      client = harvest.clients.create(FactoryGirl.attributes_for(:client))
      invoice = harvest.invoices.create(FactoryGirl.attributes_for(:invoice, :client_id => client.id))

      # check the invoice state is 'draft'
      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'draft'

      # -- mark as sent
      message = Harvest::InvoiceMessage.new(FactoryGirl.attributes_for(:invoice_message,
                                                                       :invoice_id => invoice.id,
                                                                       :body => "sent body message"))
      harvest.invoice_messages.mark_as_sent(message)

      # check the invoice state and latest message body
      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'open'
      messages = harvest.invoice_messages.all(invoice)
      messages.last.body.should == message.body

      # -- mark_as_closed (write off)
      message.body = "close body message"
      harvest.invoice_messages.mark_as_closed(message)

      # check the invoice state and latest message body
      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'closed'

      # -- re_open
      message.body = "re-open body message"
      harvest.invoice_messages.re_open(message)
      messages = harvest.invoice_messages.all(invoice)

      # check the invoice state and latest message body
      invoice = harvest.invoices.find(invoice.id)
      invoice.state.should == 'open'
    end
  end
end
