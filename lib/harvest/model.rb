module Harvest
  module Model
    def self.included(base)
      base.send :include, InstanceMethods
      base.send :extend, ClassMethods
    end
    
    module InstanceMethods
      def to_json(*args)
        as_json(*args).to_json(*args)
      end
      
      def as_json(args = {})
        inner_json = self.to_hash.stringify_keys
        inner_json.delete("cache_version")
        if self.class.skip_json_root?
          inner_json
        else
          { self.class.json_root => inner_json }
        end
      end
      
      def to_i; id; end
      
      def ==(other)
        id == other.id
      end
      
      def impersonated_user_id
        if respond_to?(:of_user) && respond_to?(:user_id)
          of_user || user_id
        elsif !respond_to?(:of_user) && respond_to?(:user_id)
          user_id
        elsif respond_to?(:of_user)
          of_user
        end
      end
      
      def json_root
        self.class.json_root
      end
    end
    
    module ClassMethods
      # This sets the API path so the API collections can use them in an agnostic way
      # @return [void]
      def api_path(path = nil)
        @_api_path ||= path
      end
      
      def skip_json_root(skip = nil)
        @_skip_json_root ||= skip
      end
      
      def skip_json_root?
        @_skip_json_root == true
      end
      
      def parse(json)
        parsed = String === json ? JSON.parse(json) : json
        Array.wrap(parsed).map {|attrs| skip_json_root? ? new(attrs) : new(attrs[json_root])}
      end
      
      def json_root
        Harvest::Model::Utility.underscore(
          Harvest::Model::Utility.demodulize(to_s)
        )
      end
      
      def wrap(model_or_attrs)
        case model_or_attrs
        when Hashie::Dash
          model_or_attrs
        when Hash
          new(model_or_attrs)
        else
          model_or_attrs
        end
      end
    end
    
    module Utility
      class << self
        
        # Both methods are shamelessly ripped from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/inflector/inflections.rb
        
        # Removes the module part from the expression in the string.
        #
        # Examples:
        #   "ActiveRecord::CoreExtensions::String::Inflections".demodulize # => "Inflections"
        #   "Inflections".demodulize
        def demodulize(class_name_in_module)
          class_name_in_module.to_s.gsub(/^.*::/, '')
        end
        
        # Makes an underscored, lowercase form from the expression in the string.
        #
        # Changes '::' to '/' to convert namespaces to paths.
        #
        # Examples:
        #   "ActiveRecord".underscore         # => "active_record"
        #   "ActiveRecord::Errors".underscore # => active_record/errors
        #
        # As a rule of thumb you can think of +underscore+ as the inverse of +camelize+,
        # though there are cases where that does not hold:
        #
        #   "SSLError".underscore.camelize # => "SslError"
        def underscore(camel_cased_word)
          word = camel_cased_word.to_s.dup
          word.gsub!(/::/, '/')
          word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
          word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
          word.tr!("-", "_")
          word.downcase!
          word
        end
      end
    end
  end
end