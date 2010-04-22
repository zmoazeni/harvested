module Harvest
  # The model that contains information about a client contact
  #
  # == Fields
  # [+id+] (READONLY) the id of the contact
  # [+client_id+] (REQUIRED) the id of the client this contact is associated with
  # [+first_name+] (REQUIRED) the first name of the contact
  # [+last_name+] (REQUIRED) the last name of the contact
  # [+email+] the email of the contact
  # [+title+] the title of the contact
  # [+phone_office+] the office phone number of the contact
  # [+phone_moble+] the moble phone number of the contact
  # [+fax+] the fax number of the contact
  class Contact < BaseModel
    include HappyMapper
    
    api_path '/contacts'
    
    element :id, Integer
    element :client_id, Integer, :tag => "client-id"
    element :email, String
    element :first_name, String, :tag => "first-name"
    element :last_name, String, :tag => "last-name"
    element :phone_office, String, :tag => "phone-office"
    element :phone_mobile, String, :tag => "phone-mobile"
    element :fax, String
    element :title, String
  end
end