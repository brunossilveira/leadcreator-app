FactoryGirl.define do
  factory :credential do
    user
    instance_url 'https://naX.salesforce.com'
    client_id 'id'
    client_secret 'secret'
  end
end