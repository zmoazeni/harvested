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
      harvest.reports.time_by_user(u, Time.parse('01/01/2000'), Time.now).each do |time|
        harvest.time.delete(time, u)
      end
      
      harvest.users.delete(u) if u.email != credentials["username"]
    end

    # harvest.reports.expenses_by_user(my_user, Time.parse('01/01/2000'), Time.now).each do |time|
    #   harvest.expenses.delete(time)
    # end
    
    # we store expenses on this date in the tests
    harvest.expenses.all("12/28/2009").each {|e| harvest.expenses.delete(e) }

    %w(expense_categories projects contacts clients tasks).each do |collection|
      harvest.send(collection).all.each {|m| harvest.send(collection).delete(m) }
    end
  end
end