module Harvest
  module API
    class Invoices < Base
      api_model Harvest::Invoice
      include Harvest::Behavior::Crud

      def all(options = {})
        status = "status=#{options[:status]}" if options[:status]
        page = "page=#{options[:page]}" if options[:page]
        updated_since = "updated_since=#{options[:updated_since]}" if options[:updated_since]
        timeframe = "from=#{options[:timeframe][:from]}&to=#{options[:timeframe][:to]}" if options[:timeframe]
        params = [status,page,updated_since,timeframe].compact.join('&')
        params = "?#{params}" if params

        response = request(:get, credentials, "/invoices#{params}")

        api_model.parse(response.parsed_response)
      end

      def download(invoice, download_path='/tmp')
        uri = URI.parse("#{credentials.host}/client/invoices/#{invoice.client_key}.pdf")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)
        download_path = "#{download_path}/#{invoice.client_key}.pdf"
        
        if response = http.request(request)
          open(download_path, "wb") do |file|
            file.write(response.body)
          end
        end
        download_path
      end
    end
  end
end
