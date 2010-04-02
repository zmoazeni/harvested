When 'I request the current rate limit I should get the following:' do |table|
  rate_limit_status = harvest_api.account.rate_limit_status
  table.rows_hash.each do |key, value|
    rate_limit_status.send(key).to_s.should == value
  end
end

