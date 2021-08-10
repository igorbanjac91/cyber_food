FactoryBot.define do 
  factory :user do 
    sequence(:email, 1000) { |n| "user#{n}@gmail.com" }
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

def user_with_orders(orders_count: 3, status: "new") 
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:order, orders_count, status: status, user: user) 
  end
end

def user_with_order
  FactoryBot.create(:user) do |user|  
    FactoryBot.create(:order, status: "new", user: user) do |order|
      FactoryBot.create_list(:order_item, 3, order: order)
    end
  end
end

def old_guest_user
  FactoryBot.create(:user, created_at: 1.week.ago)
end