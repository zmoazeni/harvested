module Harvest
  
  # The model that contains information about a project
  #
  # == Fields
  # [+id+] the id of the project
  # [+name+] (REQUIRED) the name of the project
  # [+client_id+] (REQUIRED) the client id of the project
  # [+code+] the project code
  # [+notes+] the project notes
  # [+active?+] true|false whether the project is active
  # [+billable?+] true|false where the project is billable
  # [+budget_by+] how the budget is calculated for the project +project|project_cost|task|person|nil+
  # [+budget+] what the budget is for the project (based on budget_by)
  # [+bill_by+] how to bill the project +Tasks|People|Project|nil+
  # [+hourly_rate+] what the hourly rate for the project is based on +bill_by+
  # [+notify_when_over_budget?+] whether the project will send notifications when it goes over budget
  # [+over_budget_notification_percentage+] what percentage of the budget the project has to be before it sends a notification. Based on +notify_when_over_budget?+
  # [+show_budget_to_all?+] whether the project's budget is shown to employees and contractors
  # [+basecamp_id+] (READONLY) the id of the basecamp project associated to the project
  # [+highrise_deal_id+] (READONLY) the id of the highrise deal associated to the project
  # [+active_task_assignments_count+] (READONLY) the number of active task assignments
  # [+created_at+] (READONLY) when the project was created
  # [+updated_at+] (READONLY) when the project was updated
  class Project < BaseModel
    include HappyMapper
  
    api_path '/projects'
  
    element :id, Integer
    element :client_id, Integer, :tag => 'client-id'
    element :name, String
    element :code, String
    element :notes, String
    element :fees, String
    element :active, Boolean
    element :billable, Boolean
    element :budget, Float
    element :budget_by, String, :tag => 'budget-by'
    element :hourly_rate, Float, :tag => 'hourly-rate'
    element :bill_by, String, :tag => 'bill-by'
    element :created_at, Time, :tag => 'created-at'
    element :updated_at, Time, :tag => 'updated-at'
    element :notify_when_over_budget, Boolean, :tag => 'notify-when-over-budget'
    element :over_budget_notification_percentage, Float, :tag => 'over-budget-notification-percentage'
    element :show_budget_to_all, Boolean, :tag => 'show-budget-to-all'
    element :basecamp_id, Integer, :tag => 'basecamp-id'
    element :highrise_deal_id, Integer, :tag => 'highrise-deal-id'
    element :active_task_assignments_count, Integer, :tag => 'active-task-assignments-count'
  
    alias_method :active?, :active
    alias_method :billable?, :billable
    alias_method :notify_when_over_budget?, :notify_when_over_budget
    alias_method :show_budget_to_all?, :show_budget_to_all
  end
end