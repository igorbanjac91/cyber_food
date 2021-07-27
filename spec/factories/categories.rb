FactoryBot.define do
  factory :category do
    name { "category name" }
    image { Rack::Test::UploadedFile.new('storage/local/main.jpg', 'image/jpg') }
    
    trait :invalid do 
      name { "" }
      image { nil }
    end
  end
end
