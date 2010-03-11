class Harvest
  class Request
    class << self
      def perform(method, credentials, path, params = nil, body = nil)
        Typhoeus::Request.send(method, "#{credentials.host}#{path}", :params => params, :headers => {"Accept" => "application/xml", "Content-Type" => "application/xml; charset=utf-8", "Authorization" => "Basic #{credentials.basic_auth}"}, :body => body)
      end
    end
  end
end