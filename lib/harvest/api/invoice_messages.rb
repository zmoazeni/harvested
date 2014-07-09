module Harvest
  module API
    class InvoiceMessages < Base
      api_model Harvest::InvoiceMessage
      include Harvest::Behavior::Crud

      def all(invoice)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/messages")
        api_model.parse(response.parsed_response)
      end

      def find(invoice, message)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/messages/#{message.to_i}")
        api_model.parse(response.parsed_response).first
      end

      def create(message)
        message = api_model.wrap(message)
        response = request(:post, credentials, "/invoices/#{message.invoice_id}/messages", :body => message.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(message.invoice_id, id)
      end

      def delete(message)
        request(:delete, credentials, "/invoices/#{message.invoice_id}/messages/#{message.to_i}")
        message.id
      end

      # Create a message for marking an invoice as sent.
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_sent(message)
        send_status_message(message, 'mark_as_sent')
      end

      # Create a message and mark an open invoice as closed (writing an invoice off)
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_closed(message)
        send_status_message(message, 'mark_as_closed')
      end

      # Create a message and mark a closed (written-off) invoice as open
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def re_open(message)
        send_status_message(message, 're_open')
      end

      # Create a message for marking an open invoice as draft
      #
      # @param [Harvest::InvoiceMessage] The message you want to send
      # @return [Harvest::InvoiceMessage] The sent message
      def mark_as_draft(message)
        send_status_message(message, 'mark_as_draft')
      end

      private

      def send_status_message(message, action)
        message = api_model.wrap(message)
        response = request( :post, 
                            credentials, 
                            "/invoices/#{message.invoice_id}/messages/#{action}",
                            :body => message.to_json
                          )
        message
      end

    end
  end
end
