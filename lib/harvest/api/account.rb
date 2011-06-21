module Harvest
  module API
    
    # API Methods to contain all account actions
    class Account < Base
      
      # Returns the current rate limit information
      # @return [Harvest::RateLimitStatus]
      def rate_limit_status
        response = request(:get, credentials, '/account/rate_limit_status')
        Harvest::RateLimitStatus.parse(response.body).first
      end
      
      # Returns the current logged in user
      # @return [Harvest::User]
      def who_am_i
        response = request(:get, credentials, '/account/who_am_i')
        Harvest::User.parse(response.body).first
      end
    end
  end
end