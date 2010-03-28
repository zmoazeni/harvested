class Harvest
  class Project < BaseModel
    include HappyMapper
    
    xml_name "project"
    element :id, Integer
    element :client_id, Integer, :tag => 'client-id'
    element :name, String
    element :code, String
    element :notes, String
    element :fees, String
    element :active, Boolean
    element :billable, Boolean
    element :budget, String
    element :budget_by, Float, :tag => 'budget-by'
    element :hourly_rate, Float, :tag => 'hourly-rate'
    element :bill_by, String, :tag => 'bill-by'
    
    alias_method :active?, :active
  end
end