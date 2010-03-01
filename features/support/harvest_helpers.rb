module HarvestHelpers
  def harvest_api
    Harvest.new(@subdomain, @username, @password, :ssl => @ssl)
  end
end

World(HarvestHelpers)