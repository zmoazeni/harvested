module HarvestHelpers
  def standard_api
    Harvest.client(@subdomain, @username, @password, :ssl => @ssl)
  end
  
  def harvest_api
    Harvest.hardy_client(@subdomain, @username, @password, :ssl => @ssl)
  end
end

World(HarvestHelpers)