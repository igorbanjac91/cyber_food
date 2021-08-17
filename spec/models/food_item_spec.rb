require 'rails_helper'

RSpec.describe FoodItem, type: :model do

  let (:food_item) { build(:food_item) }

  it "is valid" do 
    expect(food_item).to be_valid
  end

  describe 'validations' do 

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:price) }

    it { should validate_length_of(:name).is_at_most(30) }
    it { should validate_length_of(:description).is_at_most(250) }

    it { should validate_numericality_of(:price).only_integer }
  end

  describe 'associations' do 

    it { should belong_to(:category) }
    it { should have_one_attached(:image) }
  end
end
