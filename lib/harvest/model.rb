module Harvest
  module Model
    extend ActiveSupport::Concern
    
    included do
      cattr_accessor :stored_api_path
    end
    
    module InstanceMethods
      def to_json(*args)
        ActiveSupport::JSON.encode(as_json(*args))
      end
      
      def as_json(*)
        { self.class.json_root => to_hash }
      end
      
      def to_i; id; end
    end
    
    module ClassMethods
      # This sets the API path so the API collections can use them in an agnostic way
      # @return [void]
      def api_path(path = nil)
        self.stored_api_path ||= path
      end
      
      def parse(json)
        parsed = ActiveSupport::JSON.decode(json)
        case parsed
        when Hash
          new(parsed[json_root])
        when Array
          parsed.map {|attrs| new(attrs[json_root])}
        else
          raise "Unknown json: #{json}"
        end
      end
      
      def json_root
        to_s.demodulize.underscore
      end
    end
  end
end