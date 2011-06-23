module Harvest
  class InvoiceCategory < Hashie::Dash
    include Harvest::Model
    
    api_path '/invoice_item_categories'
    def self.json_root; "category"; end
    
    property :id
    property :name
    property :created_at
    property :updated_at
    property :use_as_expense
    property :use_as_service
    
    alias_method :use_as_expense?, :use_as_expense
    alias_method :use_as_service?, :use_as_service
  end
end