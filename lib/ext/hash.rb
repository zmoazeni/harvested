# Shamelessly ripped from https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/hash/keys.rb

unless Hash.respond_to?(:stringify_keys)
  class Hash
    # Return a new hash with all keys converted to strings.
    def stringify_keys
      dup.stringify_keys!
    end
    
    def stringify_keys!
      keys.each do |key|
        self[key.to_s] = delete(key)
      end
      self
    end
  end
end