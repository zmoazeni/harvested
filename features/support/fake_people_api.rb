class FakePeopleAPI
  def call(env)
    case env['REQUEST_METHOD']
    when 'GET'
      case env['PATH_INFO']
      when /\/people\/5001/
        [200, {}, xml('person_5001')]
      when /\/people\/?/
        [200, {}, xml('people')]
      else
        raise "Unknown ID: #{env['PATH_INFO']}"
      end
    when 'POST'
      [201, {'Location' => '/people/5001'}, '{}']
    when 'DELETE'
      [200, {}, '{}']
    else
      raise "Method [#{env['REQUEST_METHOD']}] not implemented!"
    end
  end
  
  private
    def xml(filename)
      File.read(File.dirname(__FILE__) + "/fixtures/#{filename}.xml")
    end
end