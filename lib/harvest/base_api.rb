class Harvest
  class BaseApi
    attr_reader :credentials
    
    def initialize(credentials)
      @credentials = credentials
    end
  end
end