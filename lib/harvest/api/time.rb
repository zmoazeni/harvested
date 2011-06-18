module Harvest
  module API
    class Time < Base
      
      def find(id, user = nil)
        query = user.nil? ? {} : {"of_user" => user.to_i}
        response = request(:get, credentials, "/daily/show/#{id.to_i}", :query => query)
        Harvest::TimeEntry.parse(response.body).first
      end
      
      def all(date = ::Time.now, user = nil)
        date = ::Time.parse(date) if String === date
        query = user.nil? ? {} : {"of_user" => user.to_i}
        response = request(:get, credentials, "/daily/#{date.yday}/#{date.year}", :query => query)
        Harvest::TimeEntry.parse(ActiveSupport::JSON.decode(response.body)["day_entries"])
      end
      
      def create(entry)
        response = request(:post, credentials, '/daily/add', :body => entry.to_json)
        Harvest::TimeEntry.parse(response.body).first
      end
      
      def update(entry, user = nil)
        query = user.nil? ? {} : {"of_user" => user.to_i}
        request(:put, credentials, "/daily/update/#{entry.to_i}", :body => entry.to_json, :query => query)
        find(entry.id, user)
      end
      
      def delete(entry, user = nil)
        query = user.nil? ? {} : {"of_user" => user.to_i}
        request(:delete, credentials, "/daily/delete/#{entry.to_i}", :query => query)
        entry.id
      end
    end
  end
end