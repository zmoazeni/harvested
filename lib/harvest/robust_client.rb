module Harvest
  class RobustClient < Delegator
    def initialize(client, max_retries)
      super(@client)
      @_sd_obj = @client = client
      @max_retries = max_retries
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
      RobustCollection.new(yield, @max_retries)
    end
    
    class RobustCollection < Delegator
      def initialize(collection, max_retries)
        super(@collection)
        @_sd_obj = @collection = collection
        @max_retries = max_retries
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
        retries = 0
        
        retry_func = lambda do |e|
          if retries < @max_retries
            retries += 1
            true
          else
            raise e
          end
        end
        
        begin
          yield
        rescue Harvest::RateLimited => e
          p e.response.code
          p e.response.headers
          seconds = if e.response.headers["retry-after"]
            e.response.headers["retry-after"].first.to_i
          else
            16
          end
          sleep(seconds)
          retry
        rescue Harvest::Unavailable, Harvest::InformHarvest => e
          p e.response.code
          p e.response.headers
          retry if retry_func.call(e)
        rescue Net::HTTPError, Net::HTTPFatalError => e
          retry if retry_func.call(e)
        rescue SystemCallError => e
          retry if e.is_a?(Errno::ECONNRESET) && retry_func.call(e)
        end
      end
    end
  end
end