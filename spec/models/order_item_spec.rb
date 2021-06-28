require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  let(:order_item) { create(:order_item) }

  it "is valid" do
    expect(order_item).to be_valid
  end

  it "is associated with a product" do 
    expect(order_item).to respond_to(:food_item)
  end

  it "is associated with an order" do 
    expect(order_item).to respond_to(:order)
  end

  it 'has a qunatity of at least 1' do 
    expect(order_item.quantity).to be >= 1
  end
end
