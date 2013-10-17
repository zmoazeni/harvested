module Harvest
  module API
    class Time < Base
      
      def find(id, user = nil)
        response = request(:get, credentials, "/daily/show/#{id.to_i}", :query => of_user_query(user))
        Harvest::TimeEntry.parse(response.parsed_response).first
      end
      
      def all(date = ::Time.now, user = nil)
        date = ::Time.parse(date) if String === date
        response = request(:get, credentials, "/daily/#{date.yday}/#{date.year}", :query => of_user_query(user))
        Harvest::TimeEntry.parse(JSON.parse(response.body)["day_entries"])
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
    end
  end
end