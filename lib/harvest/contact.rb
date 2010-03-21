class Harvest
  class Contact < BaseModel
    include HappyMapper
    
    element :id, Integer
    element :client_id, Integer, :tag => "client-id"
    element :email, String
    element :first_name, String, :tag => "first-name"
    element :last_name, String, :tag => "last-name"
    element :phone_office, String, :tag => "phone-office"
    element :phone_mobile, String, :tag => "phone-mobile"
    element :fax, String
  end
end