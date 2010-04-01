Then 'I reset the password of "$1"' do |email|
  person = Then %Q{there should be a person "#{email}"}
  harvest_api.people.reset_password(person)
end