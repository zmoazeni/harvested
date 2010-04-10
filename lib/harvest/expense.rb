module Harvest
  class Expense < BaseModel
    include HappyMapper
  
    api_path '/expenses'
  
    element :id, Integer
    element :notes, String
    element :units, Integer
    element :total_cost, Float, :tag => 'total-cost'
    element :project_id, Integer, :tag => 'project-id'
    element :expense_category_id, Integer, :tag => 'expense-category-id'
    element :spent_at, Time, :tag => 'spent-at'
    
    def spent_at=(date)
      @spent_at = (String === date ? Time.parse(date) : date)
    end
  end
end