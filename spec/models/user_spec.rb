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

  it 'is invalid without a password' do 
    user.password = ""
    expect(user).to_not be_valid
  end
  
  it "is invalid without an email" do 
    user.email = ""
    expect(user).to_not be_valid
  end

  it "is not an admim by default" do 
    expect(user.admin?).to be_falsy
  end

  it "has many orders" do 
    expect(user).to respond_to(:orders)
  end

  it 'has the frist name as name' do 
    expect(user.name).to eq(user.first_name)
  end

   context "when is a guest" do 

    let(:user) { build(:user, :guest) }
    
    it "is valid without first_name, last_name, email and password" do 
      expect(user).to be_valid
    end

    it "is has a name Guest" do 
      expect(user.name).to eq("Guest")
    end
  end
end
