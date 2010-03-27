class Harvest
  class ResponseValidator
    attr_reader :response
    def initialize(response)
      @response = response
    end
    
    def valid?
      case response.code
      when 503
        seconds = response.headers["retry-after"].first.to_i
        sleep(seconds)
        false
      else
        true
      end
    end
  end
end