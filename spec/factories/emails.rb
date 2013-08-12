
FactoryGirl.define do
  factory :email do
    from Faker::Internet.email
    to Faker::Internet.email
    cc Faker::Internet.email
    subject Faker::Lorem.word
    body  Faker::Lorem.paragraph
  end

end