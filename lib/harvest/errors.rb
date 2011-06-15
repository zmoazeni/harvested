module Harvest
  class InvalidCredentials < StandardError; end
  
  class HTTPError < StandardError
    attr_reader :response
    def initialize(response)
      @response = response
      super
    end
    
    def to_s
      "#{self.class.to_s} : #{response.code} #{response.body}"
    end
  end
  
  class RateLimited < HTTPError; end
  class NotFound < HTTPError; end
  class Unavailable < HTTPError; end
  class InformHarvest < HTTPError; end
  class BadRequest < HTTPError; end
  class ServerError < HTTPError; end
end