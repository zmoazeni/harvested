class Harvest
  class BaseApi
    def initialize(credentials)
      @credentials = credentials
    end
     
    protected
      def credentials; @credentials; end
  end
end