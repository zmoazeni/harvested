module Harvest
  module API
    class InvoicePayments < Base
      api_model Harvest::InvoicePayment
      include Harvest::Behavior::Crud

      def all(invoice)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/payments")
        api_model.parse(response.parsed_response)
      end

      def find(invoice, payment)
        response = request(:get, credentials, "/invoices/#{invoice.to_i}/payments/#{payment.to_i}")
        api_model.parse(response.parsed_response).first
      end

      def create(payment)
        payment = api_model.wrap(payment)
        response = request(:post, credentials, "/invoices/#{payment.invoice_id}/payments", :body => payment.to_json)
        id = response.headers["location"].match(/\/.*\/(\d+)\/.*\/(\d+)/)[2]
        find(payment.invoice_id, id)
      end

      def delete(payment)
        request(:delete, credentials, "/invoices/#{payment.invoice_id}/payments/#{payment.to_i}")
        payment.id
      end

    end
  end
end
