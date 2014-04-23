module Harvest
  module API
    class Base
      HTTP_METHODS = {
        :get => Net::HTTP::Get,
        :post => Net::HTTP::Post,
        :put => Net::HTTP::Put,
        :delete => Net::HTTP::Delete
      }

      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
      end

      class << self
        def api_model(klass)
          class_eval <<-END
            def api_model
              #{klass}
            end
          END
        end
      end

      protected
        def request(method, credentials, path, options = {})
          params = {}
          params[:path] = path
          params[:options] = options
          params[:method] = method

          url = "#{credentials.host}#{path}"

          request = HTTParty::Request.new(HTTP_METHODS[method], url,
            :query => options[:query],
            :body => options[:body],
            :format => :plain,
            :headers => {
              "Accept" => "application/json",
              "Content-Type" => "application/json; charset=utf-8",
              "User-Agent" => "Harvestable/#{Harvest::VERSION}",
            }.update(options[:headers] || {})
          )

          credentials.authenticate_request!(request)

          response = request.perform

          params[:response] = response.inspect.to_s

          case response.code
          when 200..201
            response
          when 400
            raise Harvest::BadRequest.new(response, params)
          when 401
            raise Harvest::AuthenticationFailed.new(response, params)
          when 404
            raise Harvest::NotFound.new(response, params)
          when 500
            raise Harvest::ServerError.new(response, params)
          when 502
            raise Harvest::Unavailable.new(response, params)
          when 503
            raise Harvest::RateLimited.new(response, params)
          else
            raise Harvest::InformHarvest.new(response, params)
          end
        end

        def of_user_query(user)
          query = user.nil? ? {} : {"of_user" => user.to_i}
        end
    end
  end
end
