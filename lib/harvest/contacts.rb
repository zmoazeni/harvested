class Harvest
  class Contacts < BaseApi
    
    def all(client_id = nil)
      response = if client_id
        Request.perform(:get, credentials, "/clients/#{client_id}/contacts")
      else
        Request.perform(:get, credentials, "/contacts")
      end
      
      Harvest::Models::Contact.parse(response.body)
    end
    
    def find(id)
      response = Request.perform(:get, credentials, "/contacts/#{id}")
      Harvest::Models::Contact.parse(response.body)
    end
    
    def create(params)
      builder = Builder::XmlMarkup.new
      xml = builder.contact do |c|
        %w(client_id first_name last_name).each do |field|
          mandatory_tag(c, dasherize(field), params[field])
        end
        
        %w(email phone_office phone_mobile fax).each do |field|
          optional_tag(c, dasherize(field), params[field])
        end
      end
      puts xml
      response = Request.perform(:post, credentials, "/contacts", nil, xml)
      id = response.headers_hash["Location"].match(/\/contacts\/(\d+)/)[1]
      find(id)
    end
  end
end