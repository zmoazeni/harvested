module Harvest
  module API
    class Expenses < Base
      api_model Harvest::Expense

      include Harvest::Behavior::Crud

      def all(date = ::Time.now, user = nil)
        date = ::Time.parse(date) if String === date
        response = request(:get, credentials, "#{api_model.api_path}/#{date.yday}/#{date.year}", :query => of_user_query(user))
        api_model.parse(response.parsed_response)
      end

      def attach(expense, filename, receipt)
        body = ""
        body << "--__X_ATTACH_BOUNDARY__\r\n"
        body << %Q{Content-Disposition: form-data; name="expense[receipt]"; filename="#{filename}"\r\n}
        body << "\r\n#{receipt.read}"
        body << "\r\n--__X_ATTACH_BOUNDARY__--\r\n\r\n"

        request(
          :post,
          credentials,
          "#{api_model.api_path}/#{expense.to_i}/receipt",
          :headers => {
            'Content-Type' => 'multipart/form-data; charset=utf-8; boundary=__X_ATTACH_BOUNDARY__',
            'Content-Length' => body.length.to_s,
          },
          :body => body)
      end
    end
  end
end
