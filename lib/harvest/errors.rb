module Harvest
  class InvalidCredentials < StandardError; end
  class RateLimited < StandardError;
    attr_reader :response
    def initialize(response)
      @response = response
    end
  end
end