module HarvestHelpers
  def harvest_api
    Harvest.new(@subdomain, @username, @password, :ssl => @ssl, :rate_limit_errors => @rate_limit_errors)
  end
end

World(HarvestHelpers)