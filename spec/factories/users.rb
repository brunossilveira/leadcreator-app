FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'passwordthatisnottooshort'
  end
end