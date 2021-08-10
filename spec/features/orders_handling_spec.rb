require "rails_helper"

RSpec.describe "orders handling", type: :feature do 

  let!(:admin) { create(:user, admin: true) }
  # An order for each state
  let(:user_1) { user_with_order }

  before(:each) do 
    sign_in admin
    visit root_path
  end

  describe "orders main page" do 

    it "shows all the order's id" do 
      user_1 
      click_link("Orders") 
      user_1.orders.each do |order|
        expect(page).to have_content(order.id)
      end
    end
  end
end