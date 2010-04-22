module Harvest
  # The model that contains information about a client
  #
  # == Fields
  # [+id+] (READONLY) the id of the client
  # [+name+] (REQUIRED) the name of the client
  # [+details+] the details of the client
  # [+currency+] what type of currency is associated with the client
  # [+currency_symbol+] what currency symbol is associated with the client
  # [+active?+] true|false on whether the client is active
  # [+highrise_id+] (READONLY) the highrise id associated with this client
  # [+update_at+] (READONLY) the last modification timestamp
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
    element :highrise_id, Integer, :tag => 'highrise-id'
    
    alias_method :active?, :active
  end
end