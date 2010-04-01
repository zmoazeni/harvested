module Harvest
  class Task < BaseModel
    include HappyMapper
    
    api_path '/tasks'
    
    element :id, Integer
    element :name, String
    element :billable, Boolean, :tag => 'billable-by-default'
    element :deactivated, Boolean, :tag => 'deactivated'
    element :hourly_rate, Float, :tag => 'default-hourly-rate'
    element :default, Boolean, :tag => 'is-default'
    
    def active?
      !deactivated
    end
    
    alias_method :default?, :default
  end
end