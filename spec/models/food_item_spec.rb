require 'rails_helper'

RSpec.describe FoodItem, type: :model do

  let (:food_item) { build(:food_item) }

  it "is valid" do 
    expect(food_item).to be_valid
  end

  it "is invalid without a name"  do 
    food_item.name = ""
    expect(food_item).to_not be_valid
  end

  it "is invalid without a description"  do 
    food_item.description = ""
    expect(food_item).to_not be_valid
  end
  
  it "is invalid without a price" do 
    food_item.price = ""
    expect(food_item).to_not be_valid
  end

  it 'belongs to a category' do 
    expect(food_item).to respond_to(:category)
  end
end
