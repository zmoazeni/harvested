module Harvest
  module API
    class Reports < Base
      
      def time_by_project(project, start_date, end_date, user = nil, billable = nil)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:user_id] = user.to_i if user
        query[:billable] = (billable ? "yes" : "no") unless billable.nil?
        
        response = request(:get, credentials, "/projects/#{project.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(massage_xml(response.body))
      end
      
      def time_by_user(user, start_date, end_date, project = nil, billable = nil)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:project_id] = project.to_i if project
        query[:billable] = (billable ? "yes" : "no") unless billable.nil?
        
        response = request(:get, credentials, "/people/#{user.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(massage_xml(response.body))
      end
      
      def expenses_by_user(user, start_date, end_date)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        
        response = request(:get, credentials, "/people/#{user.to_i}/expenses", :query => query)
        Harvest::Expense.parse(response.body)
      end
      
      private
        def massage_xml(original_xml)
          # this needs to be done because of the differences in dashes and underscores in the harvest api
          xml = original_xml
          %w(day-entry adjustment-record created-at project-id spent-at task-id timer-started-at updated-at user-id).each do |dash_field|
            xml = xml.gsub(dash_field, dash_field.gsub("-", "_"))
          end
          xml
        end
    end
  end
end