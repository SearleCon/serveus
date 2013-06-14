# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :interaction do
    title "MyString"
    content "MyText"
    start_at "2013-06-14 12:59:51"
    contact_person "MyString"
    contact_detail "MyString"
    target_date "2013-06-14 12:59:51"
  end
end
