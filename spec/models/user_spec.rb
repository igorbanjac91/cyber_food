require 'rails_helper'

RSpec.describe User, type: :model do
  
  let(:user) { build(:user) }
  let(:guest) { build(:user, :guest) }

  it "is a valid user" do 
    expect(user).to be_valid
  end

  describe "validations" do 

    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should allow_value("example@gmail.com").for(:email) }
    it { should_not allow_value("@gmail.com").for(:email) }
    it { should_not allow_value("example@gmail").for(:email) }

    it { should validate_length_of(:first_name).is_at_most(30) }
    it { should validate_length_of(:last_name).is_at_most(30) }

    context "user is a guest" do
      
      it "is valid without first_name, last_name, email and password" do 
        expect(guest).to be_valid
      end

      it "is has a name Guest" do 
        expect(guest.first_name).to eq("Guest")
      end
    end
  end

  describe "associations" do 

    it { should have_many(:orders) }
  end

  it "is not an admim by default" do 
    expect(user.admin?).to be_falsy
  end

  it 'has the frist name as name' do 
    expect(user.name).to eq(user.first_name)
  end
end
