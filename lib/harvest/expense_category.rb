module Harvest
  class ExpenseCategory < BaseModel
    include HappyMapper
    
    tag 'expense-category'
    api_path '/expense_categories'
    
    element :id, Integer
    element :name, String
    element :unit_name, String, :tag => 'unit-name'
    element :unit_price, Float, :tag => 'unit-price'
    element :deactivated, Boolean
    
    def active?
      !deactivated
    end
  end
end