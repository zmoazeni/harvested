module Harvest
  # The model that contains information about a client
  #
  # == Fields
  # [+id+] the id of the client
  # [+name+] (REQUIRED) the name of the client
  # [+details+] the details of the client
  # [+currency+] what type of currency is associated with the client
  # [+currency_symbol+] what currency symbol is associated with the client
  # [+update_at+] the last modification timestamp
  # [+active?+] true|false on whether the client is active
  class Client < BaseModel
    include HappyMapper
  
    api_path '/clients'
  
    element :id, Integer
    element :active, Boolean
    element :name, String
    element :details, String
    element :currency, String
    element :currency_symbol, String, :tag => "currency-symbol"
    element :cache_version, Integer, :tag => "cache-version"
    element :updated_at, Time, :tag => "updated-at"
    
    alias_method :active?, :active
  end
end