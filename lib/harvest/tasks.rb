module Harvest
  class Tasks < BaseApi
    api_methods crud
    api_model Harvest::Task
    
    include Harvest::Crud
  end
end