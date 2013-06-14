# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
    name "MyString"
    user
    open true
  end
end
