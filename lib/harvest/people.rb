module Harvest
  class People < BaseApi
    api_methods crud + activatable + %w(reset_password)
    api_model Harvest::Person
    
    include Harvest::Crud
    include Harvest::Activatable
    
    def reset_password(person)
      request(:post, credentials, "/people/#{person.id}/reset_password")
      person
    end
  end
end