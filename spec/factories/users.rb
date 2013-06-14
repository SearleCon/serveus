# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password 'changeme'
    password_confirmation 'changeme'
  end
end
