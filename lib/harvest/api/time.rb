module Harvest
  module API
    class Time < Base
      
      def find(id)
        response = request(:get, credentials, "/daily/show/#{id}")
        Harvest::TimeEntry.parse(response.body, :single => true)
      end
      
      def all(date = ::Time.now)
        date = ::Time.strptime(date,'%m/%d/%Y') if String === date
        response = request(:get, credentials, "/daily/#{date.yday}/#{date.year}")
        Harvest::TimeEntry.parse(response.body)
      end
      
      def create(entry)
        response = request(:post, credentials, '/daily/add', :body => entry.to_xml)
        Harvest::TimeEntry.parse(response.body).first
      end
      
      def update(entry)
        request(:put, credentials, "/daily/update/#{entry.to_i}", :body => entry.to_xml)
        find(entry.id)
      end
      
      def delete(entry)
        request(:delete, credentials, "/daily/delete/#{entry.to_i}")
        entry.id
      end
    end
  end
end
