class Harvest
  class Contacts < BaseApi
    
    def all(client_id = nil)
      response = if client_id
        Request.perform(:get, credentials, "/clients/#{client_id}/contacts")
      else
        Request.perform(:get, credentials, "/contacts")
      end
      
      Harvest::Contact.parse(response.body)
    end
    
    def find(id)
      response = Request.perform(:get, credentials, "/contacts/#{id}")
      Harvest::Contact.parse(response.body)
    end
    
    def create(contact)
      response = Request.perform(:post, credentials, "/contacts", nil, contact.to_xml)
      id = response.headers_hash["Location"].match(/\/contacts\/(\d+)/)[1]
      find(id)
    end
    
    def update(contact)
      Request.perform(:put, credentials, "/contacts/#{contact.id}", nil, contact.to_xml)
      find(contact.id)
    end
    
    def delete(contact)
      Request.perform(:delete, credentials, "/contacts/#{contact.id}")
      contact.id
    end
  end
end