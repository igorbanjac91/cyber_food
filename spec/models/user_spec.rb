require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { build(:user) }

  it "is a valid user" do 
    expect(user).to be_valid
  end

  it "is invalid without a first name" do 
    user.first_name = ""
    expect(user).to_not be_valid
  end

  it "is invalid without a last name" do 
    user.last_name = ""
    expect(user).to_not be_valid
  end

  it "is not an admim by default" do 
    expect(user.admin?).to be_falsy
  end

  it "has many orders" do 
    expect(user).to respond_to(:orders)
  end
end
