module Harvest
  module API
    class Reports < Base

      TIME_FORMAT = '%Y%m%d'

      def time_by_project(project, start_date, end_date, options = {})
        query = { from: start_date.strftime(TIME_FORMAT), to: end_date.strftime(TIME_FORMAT) }
        query[:user_id]       = options.delete(:user).to_i if options[:user]
        query[:billable]      = (options.delete(:billable) ? "yes" : "no") unless options[:billable].nil?
        query[:updated_since] = options.delete(:updated_since).to_s if options[:updated_since]
        query.update(options)

        response = request(:get, credentials, "/projects/#{project.to_i}/entries", query: query)
        Harvest::TimeEntry.parse(JSON.parse(response.body).map {|h| h["day_entry"]})
      end

      def time_by_user(user, start_date, end_date, options = {})
        query = { from: start_date.strftime(TIME_FORMAT), to: end_date.strftime(TIME_FORMAT) }
        query[:project_id]    = options.delete(:project).to_i if options[:project]
        query[:billable]      = (options.delete(:billable) ? "yes" : "no") unless options[:billable].nil?
        query[:updated_since] = options.delete(:updated_since).to_s if options[:updated_since]
        query.update(options)

        response = request(:get, credentials, "/people/#{user.to_i}/entries", query: query)
        Harvest::TimeEntry.parse(JSON.parse(response.body).map {|h| h["day_entry"]})
      end

      def expenses_by_user(user, start_date, end_date, options = {})
        query = { from: start_date.strftime(TIME_FORMAT), to: end_date.strftime(TIME_FORMAT) }
        query[:updated_since] = options.delete(:updated_since).to_s if options[:updated_since]
        query.update(options)

        response = request(:get, credentials, "/people/#{user.to_i}/expenses", query: query)
        Harvest::Expense.parse(response.parsed_response)
      end

      def expenses_by_project(project, start_date, end_date, options = {})
        query = { from: start_date.strftime(TIME_FORMAT), to: end_date.strftime(TIME_FORMAT) }
        query[:updated_since] = options.delete(:updated_since).to_s if options[:updated_since]
        query.update(options)

        response = request(:get, credentials, "/projects/#{project.to_i}/expenses", query: query)
        Harvest::Expense.parse(response.parsed_response)
      end

      def projects_by_client(client)
        response = request(:get, credentials, "/projects?client=#{client.to_i}")
        Harvest::Project.parse(response.parsed_response)
      end
    end
  end
end
