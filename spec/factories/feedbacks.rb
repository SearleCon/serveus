# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    subject Faker::Lorem.sentence
    comment Faker::Lorem.paragraph
  end
end
