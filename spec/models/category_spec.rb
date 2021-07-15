require 'rails_helper'

RSpec.describe Category, type: :model do
  
  let(:category) { build(:category) }

  it 'is a valid category' do 
    expect(category).to be_valid
  end

  it 'is invalid without a name' do 
    category.name = nil
    expect(category).to_not be_valid
  end

  it 'has a relationship with food items' do 
    expect(category).to respond_to(:food_items)
  end
end
