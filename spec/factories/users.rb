FactoryBot.define do 
  factory :user do 
    email       { "bobbyfish@gmail.com"}
    first_name  { "Bob" }
    last_name   { "Fish" }
    password              { "password" }
    password_confirmation { "password" }
    admin { false }
    guest { false }

    trait :guest do 
      guest      { true }
      email      { nil }
      first_name { nil }
      last_name  { nil }
      password              { nil }
      password_confirmation { nil }
    end

    trait :admin do 
      admim { true }
    end
  end
end