require 'rails_helper'

RSpec.describe OrderItem, type: :model do

  let(:order_item) { create(:order_item) }

  it "is valid" do
    expect(order_item).to be_valid
  end

  it { should belong_to(:food_item) }

  it { should belong_to(:order) }

end
