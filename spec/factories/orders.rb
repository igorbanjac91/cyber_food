FactoryBot.define do
  factory :order do
    association :user 
    status { "new" }
  end
end
