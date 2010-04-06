Then 'I reset the password of "$1"' do |email|
  user = Then %Q{there should be a user "#{email}"}
  harvest_api.users.reset_password(user)
end