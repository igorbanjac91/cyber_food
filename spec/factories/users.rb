FactoryBot.define do 
  factory :user do 
    email       { "bobbyfish@gmail.com"}
    first_name  { "Bob"}
    last_name   { "Fish"}
    password              { "password" }
    password_confirmation { "password" }
    admin { false }
  end
end