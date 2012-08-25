module Harvest

  # The model that contains information about a task
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
  class User < Hashie::Mash
    include Harvest::Model

    api_path '/people'

    delegate_methods(:active?     => :is_active,
                     :admin?      => :is_admin,
                     :contractor? => :is_contractor)

    def initialize(args = {}, _ = nil)
      args             = args.to_hash.stringify_keys
      args["is_admin"] = args.delete("admin") if args["admin"]
      self.timezone    = args.delete("timezone") if args["timezone"]
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
