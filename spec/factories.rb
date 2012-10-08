FactoryGirl.define do
  sequence :name do |n|
    "Joe's Steam Cleaning #{n}"
  end

  factory :client, class: Harvest::Client do
    name
    details "Building API Widgets across the country"
  end
end
