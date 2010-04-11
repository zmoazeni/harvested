module Harvest
  module API
    class Reports < Base
      
      def time_by_project(project, start_date, end_date, user = nil)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:user_id] = user.to_i if user
        
        response = request(:get, credentials, "/projects/#{project.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(response.body.gsub("day-entry", "day_entry"))
      end
      
      def time_by_user(user, start_date, end_date, project = nil)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:project_id] = project.to_i if project
        
        response = request(:get, credentials, "/people/#{user.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(response.body.gsub("day-entry", "day_entry"))
      end
      
      def expenses_by_user(user, start_date, end_date)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        
        response = request(:get, credentials, "/people/#{user.to_i}/expenses", :query => query)
        Harvest::Expense.parse(response.body)
      end
    end
  end
end