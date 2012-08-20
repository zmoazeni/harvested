module Harvest

  # The model that contains information about a user of the system which is
  # accessed via the /people API call in the Harvest API.
  #
  # == Fields
  # [+id+] (READONLY) the id of the user
  # [+email+] the email of the user
  # [+first_name+] the first name for the user
  # [+last_name+] the last name for the user
  # [+telephone+] the telephone for the user
  # [+department] the department for the user
  # [+has_access_to_all_future_projects+] whether the user should be added to future projects by default
  # [+hourly_rate+] what the default hourly rate for the user is
  # [+admin?+] whether the user is an admin
  # [+contractor?+] whether the user is a contractor
  # [+contractor?+] whether the user is a contractor
  # [+timezone+] the timezone for the user.
  class User < Hashie::Dash
    include Harvest::Model

    api_path '/people'
    property :cache_version
    property :created_at
    property :default_expense_category_id
    property :default_expense_project_id
    property :default_hourly_rate
    property :default_task_id
    property :default_time_project_id
    property :department
    property :duplicate_timesheet_wants_notes
    property :email
    property :email_after_submit
    property :first_name
    property :first_timer
    property :has_access_to_all_future_projects
    property :id
    property :identity_url
    property :is_active
    property :is_admin
    property :is_contractor
    property :last_name
    property :opensocial_identifier
    property :password
    property :password_change_required
    property :preferred_approval_screen
    property :preferred_entry_method
    property :preferred_project_status_reports_screen
    property :telephone
    property :timestamp_timers
    property :timezone
    property :twitter_username
    property :updated_at
    property :wants_newsletter
    property :wants_timesheet_duplication
    property :wants_weekly_digest
    property :weekly_digest_sent_on

    alias_method :active?, :is_active
    alias_method :admin?, :is_admin
    alias_method :contractor?, :is_contractor
    alias_method :password_change_required?, :password_change_required

    def initialize(args = {})
      args          = args.stringify_keys
      args["is_admin"] = args.delete("admin") if args["admin"]
      self.timezone = args.delete("timezone") if args["timezone"]
      super
    end

    # Sets the timezone for the user. This can be done in a variety of ways.
    #
    # == Examples
    #   user.timezone = :cst # the easiest way. CST, EST, MST, and PST are supported
    #
    #   user.timezone = 'america/chicago' # a little more verbose
    #
    #   user.timezone = 'Central Time (US & Canada)' # the most explicit way
    def timezone=(timezone)
      tz = timezone.to_s.downcase
      case tz
      when 'cst', 'cdt' then self.timezone = 'america/chicago'
      when 'est', 'edt' then self.timezone = 'america/new_york'
      when 'mst', 'mdt' then self.timezone = 'america/denver'
      when 'pst', 'pdt' then self.timezone = 'america/los_angeles'
      else
        if Harvest::Timezones::MAPPING[tz]
          self["timezone"] = Harvest::Timezones::MAPPING[tz]
        else
          self["timezone"] = timezone
        end
      end
    end
  end
end