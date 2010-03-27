class FakeRateLimit
  def initialize(sleep_seconds)
    @sleep_seconds = sleep_seconds
    @requests = 0
  end
  
  def call(env)
    @requests += 1
    case @requests
    when 1
      [503, {"Retry-After" => "#{@sleep_seconds}"}, "Rate limited"]
    else
      if env["PATH_INFO"] == "/clients"
        [200, {'Content-Type' => 'application/xml'}, File.read(File.dirname(__FILE__) + "/fixtures/empty_clients.xml")]
      else
        [404, {}, "Not Found"]
      end
    end
  end
end