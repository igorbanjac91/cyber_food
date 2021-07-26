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
      email      { "" }
      first_name { "" }
      last_name  { "" }
      password              { "" }
      password_confirmation { "" }
    end

    trait :admin do 
      admim { true }
    end
  end
end