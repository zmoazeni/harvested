FactoryGirl.define do
  sequence :name do |n|
    "Joe's Steam Cleaning #{n}"
  end

  factory :client, class: Harvest::Client do
    name
    details "Building API Widgets across the country"
  end

  sequence :project_name do |n|
    "Joe's Steam Cleaning Project #{n}"
  end

  factory :project, class: Harvest::Project do
    name { generate(:project_name) }
  end
end
