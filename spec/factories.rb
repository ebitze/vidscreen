FactoryGirl.define do
  factory :user do
    sequence(:name)     { |n| "Person #{n}" }
    sequence(:email)    { |n| "person_#{n}@test.com" }
    password  "123456789"
    password_confirmation "123456789"

    factory :admin do
      admin true
    end
  end
end
