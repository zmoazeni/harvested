module HarvestHelpers
  def standard_api
    Harvest.client(@subdomain, @username, @password, :ssl => @ssl)
  end
  
  def harvest_api
    Harvest.robust_client(@subdomain, @username, @password, :ssl => @ssl)
  end
end

World(HarvestHelpers)