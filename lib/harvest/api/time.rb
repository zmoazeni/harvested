module Harvest
  module API
    class Time < Base
      
      def find(id, user = nil)
        response = request(:get, credentials, "/daily/show/#{id.to_i}", :query => of_user_query(user))
        Harvest::TimeEntry.parse(response.parsed_response).first
      end

      def all(user = nil, max_days = 0)
        entries_by_day = (0..max_days).collect do |days_ago|
          Harvest::TimeEntry.parse(daily(days_ago.days.ago, user)["day_entries"])
        end
        entries_by_day.flatten
      end

      def recent(limit = 10, days = 7)
        all(max_days = days)[0...limit]
      end

      def by_date(date = ::Time.now, user = nil)
        Harvest::TimeEntry.parse(daily(date, user)["day_entries"])
      end

      def trackable_projects(date = ::Time.now, user = nil)
        Harvest::TrackableProject.parse(daily(date, user)["projects"])
      end
      
      def toggle(id, user = nil)
        response = request(:get, credentials, "/daily/timer/#{id}", :query => of_user_query(user))
        Harvest::TimeEntry.parse(response.parsed_response).first
      end

      def create(entry, user = nil)
        response = request(:post, credentials, '/daily/add', :body => entry.to_json, :query => of_user_query(user))
        Harvest::TimeEntry.parse(response.parsed_response).first
      end

      def update(entry, user = nil)
        request(:put, credentials, "/daily/update/#{entry.to_i}", :body => entry.to_json, :query => of_user_query(user))
        find(entry.id, user)
      end
      
      def delete(entry, user = nil)
        request(:delete, credentials, "/daily/delete/#{entry.to_i}", :query => of_user_query(user))
        entry.id
      end


      private

      def daily(date, user)
        date = ::Time.parse(date) if String === date
        response = request(:get, credentials, "/daily/#{date.yday}/#{date.year}", :query => of_user_query(user))
        JSON.parse(response.body)
      end
    end
  end
end
