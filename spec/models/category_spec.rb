require 'rails_helper'

RSpec.describe Category, type: :model do
  
  let(:category) { build(:category) }

  it 'is a valid category' do 
    expect(category).to be_valid
  end

  describe "validations" do 

    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(30) }
  end

  describe "associations" do 

    it { should have_many(:food_items) }
    it { should have_one_attached(:image) }
  end
end
