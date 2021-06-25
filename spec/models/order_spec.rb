require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:order) { create(:order) }

  it "is valid" do 
    expect(order).to be_valid
  end

  it "is invalid without an user associated" do 
    order.user_id = nil
    expect(order).to_not be_valid
  end

  it "has many order items associated" do 
    expect(order).to respond_to(:order_items)
  end

end
