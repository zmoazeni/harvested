module Harvest
  
  # The model that contains information about a task
  #
  # == Fields
  # [+id+] (READONLY) the id of the task
  # [+name+] (REQUIRED) the name of the task
  # [+billable+] whether the task is billable by default
  # [+deactivated+] whether the task is deactivated
  # [+hourly_rate+] what the default hourly rate for the task is
  # [+default?+] whether to add this task to new projects by default
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