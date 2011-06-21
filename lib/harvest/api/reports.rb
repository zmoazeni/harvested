module Harvest
  module API
    class Reports < Base
      
      def time_by_project(project, start_date, end_date, options = {})
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:user_id] = options[:user].to_i if options[:user]
        query[:billable] = (options[:billable] ? "yes" : "no") unless options[:billable].nil?
        
        response = request(:get, credentials, "/projects/#{project.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(JSON.parse(response.body).map {|h| h["day_entry"]})
      end
      
      def time_by_user(user, start_date, end_date, options = {})
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        query[:project_id] = options[:project].to_i if options[:project]
        query[:billable] = (options[:billable] ? "yes" : "no") unless options[:billable].nil?
        
        response = request(:get, credentials, "/people/#{user.to_i}/entries", :query => query)
        Harvest::TimeEntry.parse(JSON.parse(response.body).map {|h| h["day_entry"]})
      end
      
      def expenses_by_user(user, start_date, end_date)
        query = {:from => start_date.strftime("%Y%m%d"), :to => end_date.strftime("%Y%m%d")}
        
        response = request(:get, credentials, "/people/#{user.to_i}/expenses", :query => query)
        Harvest::Expense.parse(response.parsed_response)
      end
    end
  end
end