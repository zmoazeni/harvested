module Harvest

  # The model that contains information about a project
  #
  # == Fields
  # [+id+] (READONLY) the id of the project
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
  class Project < Hashie::Dash
    include Harvest::Model

    api_path '/projects'

    property :id
    property :client_id
    property :name
    property :code
    property :notes
    property :fees
    property :active
    property :billable
    property :budget
    property :budget_by
    property :hourly_rate
    property :bill_by
    property :created_at
    property :updated_at
    property :notify_when_over_budget
    property :over_budget_notification_percentage
    property :show_budget_to_all
    property :basecamp_id
    property :highrise_deal_id
    property :active_task_assignments_count
    property :over_budget_notified_at
    property :earliest_record_at
    property :cost_budget
    property :cost_budget_include_expenses
    property :latest_record_at
    property :estimate_by
    property :hint_earliest_record_at
    property :hint_latest_record_at
    property :active_user_assignments_count
    property :cache_version
    property :estimate

    alias_method :active?, :active
    alias_method :billable?, :billable
    alias_method :notify_when_over_budget?, :notify_when_over_budget
    alias_method :show_budget_to_all?, :show_budget_to_all
    
    def as_json(args = {})
      super(args.update(:except => %w(hint_earliest_record_at hint_latest_record_at cache_version)))
    end
    
    def self.parse(json)
      parsed = ActiveSupport::JSON.decode(json)
      Array.wrap(parsed).each do |attrs| 
        # need to cleanup some attributes
        project_attrs = attrs.fetch(json_root, {})
        project_attrs["hint_latest_record_at"]   = project_attrs.delete("hint-latest-record-at")
        project_attrs["hint_earliest_record_at"] = project_attrs.delete("hint-earliest-record-at")
      end
      super(parsed)
    end
  end
end