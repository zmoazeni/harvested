module Harvest
  class RobustClient < Delegator
    def initialize(client)
      super(@client)
      @_sd_obj = @client = client
      @client.api_methods.each do |name|
        instance_eval <<-END
          def #{name}(*args)
            wrap_collection do
              @client.send('#{name}', *args)
            end
          end
        END
      end
    end
    
    def __getobj__; @_sd_obj; end
    def __setobj__(obj); @_sd_obj = obj; end
    
    def wrap_collection
      RobustCollection.new(yield)
    end
    
    class RobustCollection < Delegator
      def initialize(collection)
        super(@collection)
        @_sd_obj = @collection = collection
        @collection.api_methods.each do |name|
          instance_eval <<-END
            def #{name}(*args)
              retry_rate_limits do
                @collection.send('#{name}', *args)
              end
            end
          END
        end
      end
      
      def __getobj__; @_sd_obj; end
      def __setobj__(obj); @_sd_obj = obj; end
      
      def retry_rate_limits
        yield
      rescue Harvest::RateLimited => e
        seconds = e.response.headers["retry-after"].first.to_i
        sleep(seconds)
        retry
      end
    end
  end
end