module HarvestedHelpers
  def self.credentials
    raise "You need a credentials file in support/harvest_credentials.yml!!" unless File.exist?("#{File.dirname(__FILE__)}/harvest_credentials.yml")
    @credentials ||= YAML.load_file("#{File.dirname(__FILE__)}/harvest_credentials.yml")
  end
  def credentials; HarvestedHelpers.credentials; end
  
  def self.simple_harvest
    Harvest.client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => true)
  end
  
  # def connect_to_harvest
  #   @harvest = Harvest.hardy_client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => true)
  # end
  
  # def harvest; @harvest; end
  def harvest; @harvest ||= HarvestedHelpers.simple_harvest; end
  
  def hardy_harvest
    Harvest.hardy_client(credentials["subdomain"], credentials["username"], credentials["password"], :ssl => true)
  end
  
  def self.clean_remote
    harvest = simple_harvest
    harvest.users.all.each do |u|
      harvest.reports.expenses_by_user(u, Time.utc(2000, 1, 1), Time.utc(2011, 6,21)).each do |expense|
        harvest.expenses.delete(expense, u)
      end
      
      harvest.reports.time_by_user(u, Time.utc(2000, 1, 1), Time.utc(2011, 6,21)).each do |time|
        harvest.time.delete(time, u)
      end
      
      harvest.users.delete(u) if u.email != credentials["username"]
    end

    # we store expenses on this date in the tests
    harvest.expenses.all(Time.utc(2009, 12, 28)).each {|e| harvest.expenses.delete(e) }

    %w(expense_categories projects contacts clients tasks).each do |collection|
      harvest.send(collection).all.each {|m| harvest.send(collection).delete(m) }
    end
  end
end