# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :attachment do
    name "MyString"
    image File.new(Rails.root.join('spec', 'images', 'test.png'))
  end
end
