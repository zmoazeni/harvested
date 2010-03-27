class Harvest
  class ResponseValidator
    attr_reader :response
    attr_reader :rate_limits_errors
    def initialize(response, rate_limits_errors)
      @response = response
      @rate_limits_errors = rate_limits_errors
    end
    
    def valid?
      case response.code
      when 503
        raise Harvest::RateLimited.new(response) if rate_limits_errors
        seconds = response.headers["retry-after"].first.to_i
        sleep(seconds)
        false
      else
        true
      end
    end
  end
end