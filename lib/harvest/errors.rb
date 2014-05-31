module Harvest
  class HTTPError < StandardError
    attr_reader :response
    attr_reader :params
    attr_reader :hint

    def initialize(response, params = {}, hint = nil)
      @response = response
      @params = params
      @hint = hint
      super(response)
    end

    def to_s
      "#{self.class.to_s} : #{response.code} #{response.body}" + (hint ? "\n#{hint}" : "")
    end
  end

  class RateLimited < HTTPError; end
  class NotFound < HTTPError; end
  class Unavailable < HTTPError; end
  class InformHarvest < HTTPError; end
  class BadRequest < HTTPError; end
  class ServerError < HTTPError; end
  class AuthenticationFailed < HTTPError ; end
end
