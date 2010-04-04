module Harvest
  module API
    class Account < Base
      def rate_limit_status
        response = request(:get, credentials, '/account/rate_limit_status')
        Harvest::RateLimitStatus.parse(response.body)
      end
    end
  end
end