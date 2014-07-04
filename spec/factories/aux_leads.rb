FactoryGirl.define do
  factory :aux_lead do
    name Faker::Name.first_name
    last_name Faker::Name.last_name
    email Faker::Internet.email
    company Faker::Company.name
    job_title Faker::Lorem.sentence(3)
    phone Faker::PhoneNumber.phone_number
    website Faker::Internet.url
  end
end