class Harvest
  class Contacts < BaseApi
    api_methods crud
    
    def all(client_id = nil)
      response = if client_id
        request(:get, credentials, "/clients/#{client_id}/contacts")
      else
        request(:get, credentials, "/contacts")
      end
      
      Harvest::Contact.parse(response.body)
    end
    
    def find(id)
      response = request(:get, credentials, "/contacts/#{id}")
      Harvest::Contact.parse(response.body)
    end
    
    def create(contact)
      response = request(:post, credentials, "/contacts", :body => contact.to_xml)
      id = response.headers["location"].first.match(/\/contacts\/(\d+)/)[1]
      find(id)
    end
    
    def update(contact)
      request(:put, credentials, "/contacts/#{contact.id}", :body => contact.to_xml)
      find(contact.id)
    end
    
    def delete(contact)
      request(:delete, credentials, "/contacts/#{contact.id}")
      contact.id
    end
  end
end