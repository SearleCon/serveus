# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :incident do
    ignore do
      tagged_with 'MyString'
    end


    name "MyString"
    user
    open true

    trait :with_tagged_interaction do
      after(:create) do |incident, evaluator|
        incident.interactions << FactoryGirl.create(:interaction)
        incident.interactions.first.tags << FactoryGirl.create(:tag, name: evaluator.tagged_with)
      end
    end
  end
end
