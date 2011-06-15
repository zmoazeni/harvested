module Harvest
  module Model
    extend ActiveSupport::Concern
    
    included do
      cattr_accessor :_api_path, :_skip_json_root
    end
    
    module InstanceMethods
      def to_json(*args)
        ActiveSupport::JSON.encode(as_json(*args))
      end
      
      def as_json(*)
        if self.class.skip_json_root?
          super
        else
          { self.class.json_root => super }
        end
      end
      
      def to_i; id; end
      
      def ==(other)
        id == other.id
      end
    end
    
    module ClassMethods
      # This sets the API path so the API collections can use them in an agnostic way
      # @return [void]
      def api_path(path = nil)
        self._api_path ||= path
      end
      
      def skip_json_root(skip = nil)
        self._skip_json_root ||= skip
      end
      
      def skip_json_root?
        _skip_json_root == true
      end
      
      def parse(json)
        parsed = String === json ? ActiveSupport::JSON.decode(json) : json
        Array.wrap(parsed).map {|attrs| skip_json_root? ? new(attrs) : new(attrs[json_root])}
      end
      
      def json_root
        to_s.demodulize.underscore
      end
      
      def wrap(model_or_attrs)
        case model_or_attrs
        when Hash
          new(model_or_attrs)
        else
          model_or_attrs
        end
      end
    end
  end
end