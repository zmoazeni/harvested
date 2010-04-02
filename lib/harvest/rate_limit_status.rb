module Harvest
  class RateLimitStatus < BaseModel
    include HappyMapper
    
    tag 'hash'
    element :last_access_at, DateTime, :tag => 'last-access-at'
    element :count, Integer
    element :timeframe_limit, Integer, :tag => 'timeframe-limit'
    element :max_calls, Integer, :tag => 'max-calls'
    element :lockout_seconds, Integer, :tag => 'lockout-seconds'
    
    def over_limit?
      count > max_calls
    end
  end
end