module Harvest
  class Clients < BaseApi
    api_methods crud + activatable
    api_model Harvest::Client
    
    include Harvest::Crud
    include Harvest::Activatable
  end
end