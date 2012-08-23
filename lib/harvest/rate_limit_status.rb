module Harvest

  # The model that contains the information about the user's rate limit
  #
  # == Fields
  # [+last_access_at+]  The last registered request
  # [+count+] The current number of requests registered
  # [+timeframe_limit+] The amount of seconds before a rate limit refresh occurs
  # [+max_calls+] The number of requests you can make within the +timeframe_limit+
  # [+lockout_seconds+] If you exceed the rate limit, how long you will be locked out from Harvest
  class RateLimitStatus < Hashie::Mash
    include Harvest::Model

    skip_json_root true

    # Returns true if the user is over their rate limit
    # @return [Boolean]
    # @see http://www.getharvest.com/api
    def over_limit?
      count > max_calls
    end
  end
end
