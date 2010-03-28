module HarvestHelpers
  def standard_api
    Harvest.new(@subdomain, @username, @password, :ssl => @ssl)
  end
  
  def harvest_api
    Harvest::RobustClient.new(standard_api)
  end
end

World(HarvestHelpers)