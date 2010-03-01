class Harvest
  module Models
    class Client
      include HappyMapper
  
      element :id, Integer
      element :active, Boolean
      element :name, String
      element :details, String
      element :currency, String
      element :currency_symbol, String, :tag => "currency-symbol"
      element :cache_version, Integer, :tag => "cache-version"
      element :updated_at, Time, :tag => "updated-at"
      
      def ==(other)
        id == other.id
      end
    end
  end
end