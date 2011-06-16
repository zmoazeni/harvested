module Harvest
  class ExpenseCategory < Hashie::Dash
    include Harvest::Model
    api_path '/expense_categories'
    
    property :id
    property :name
    property :unit_name
    property :unit_price
    property :deactivated
    property :created_at
    property :updated_at
    property :cache_version
    
    def active?
      !deactivated
    end
  end
end