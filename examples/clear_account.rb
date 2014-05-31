# This is commented out because it can be very dangerous if run against a production account

# require "harvested"
#
# subdomain = 'yoursubdomain'
# username = 'yourusername'
# password = 'yourpassword'
#
# api = Harvest.hardy_client(subdomain: subdomain, username: username, password: password)
#
# raise "Are you sure you want to do this? (comment out this exception if so)"
#
# api.users.all.each do |u|
#   api.users.delete(u) if u.email != username
# end
# my_user = api.users.all.first
#
# api.reports.time_by_user(my_user, Time.parse('01/01/2000'), Time.now).each do |time|
#   api.time.delete(time)
# end
#
# api.reports.expenses_by_user(my_user, Time.parse('01/01/2000'), Time.now).each do |time|
#   api.expenses.delete(time)
# end
#
# %w(expenses expense_categories projects contacts clients tasks).each do |collection|
#   api.send(collection).all.each {|m| api.send(collection).delete(m) }
# end
