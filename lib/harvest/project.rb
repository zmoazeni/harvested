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
  class Project < Hashie::Mash
    include Harvest::Model

    api_path '/projects'

    def as_json(args = {})
      super(args).tap do |json|
        json[json_root].delete("hint_earliest_record_at")
        json[json_root].delete("hint_latest_record_at")
      end
    end

    def self.parse(json)
      json = String === json ? JSON.parse(json) : json
      Array.wrap(json).each do |attrs|
        # need to cleanup some attributes
        project_attrs = attrs[json_root] || {}
        project_attrs["hint_latest_record_at"]   = project_attrs.delete("hint-latest-record-at")
        project_attrs["hint_earliest_record_at"] = project_attrs.delete("hint-earliest-record-at")
      end
      super(json)
    end
  end
end
