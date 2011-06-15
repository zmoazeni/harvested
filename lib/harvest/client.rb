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
  class Client < Hashie::Dash
    include Harvest::Model
    
    api_path '/clients'
    

    property :id
    property :active
    property :name
    property :details
    property :currency
    property :currency_symbol
    property :cache_version
    property :created_at
    property :updated_at
    property :highrise_id
    property :default_invoice_timeframe
    
    alias_method :active?, :active
  end
end