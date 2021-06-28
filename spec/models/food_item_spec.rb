require 'rails_helper'

RSpec.describe FoodItem, type: :model do

  let (:food_item) { build(:food_item) }

  it "is valid" do 
    expect(food_item).to be_valid
  end
end
