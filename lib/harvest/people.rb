class Harvest
  class People < BaseApi
    api_methods crud + activatable + %w(reset_password)
    
    def all
      response = request(:get, credentials, "/people")
      Harvest::Person.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "/people/#{id}")
      Harvest::Person.parse(response.body)
    end
    
    def create(client)
      response = request(:post, credentials, "/people", :body => client.to_xml)
      id = response.headers["location"].first.match(/\/people\/(\d+)/)[1]
      find(client.id)
    end
    
    def update(person)
      request(:put, credentials, "/people/#{person.id}", :body => person.to_xml)
      find(person.id)
    end
    
    def delete(person)
      request(:delete, credentials, "/people/#{person.id}")
      person.id
    end
    
    def deactivate(person)
      if person.active?
        request(:post, credentials, "/people/#{person.id}/toggle")
        person.active = false
      end
      person
    end
    
    def activate(person)
      if !person.active?
        request(:post, credentials, "/people/#{person.id}/toggle")
        person.active = true
      end
      person
    end
  end
end