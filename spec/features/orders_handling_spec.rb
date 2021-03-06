require "rails_helper"

RSpec.describe "orders handling", type: :feature, js: true do 

  let!(:admin) { create(:user, admin: true) }
  let!(:user_1) { user_with_ordered_order }

  before(:each) do 
    sign_in admin
    visit root_path
  end

  describe "orders main page" do 

    it "shows all the order's id"  do 
      click_link("Orders")
      user_1.orders.each do |order|
        expect(page).to have_content(order.id)
      end
    end
    
    it "shows all the order's status"  do 
      click_link("Orders")
      user_1.orders.each do |order|
        expect(page).to have_content(order.status)
      end
    end

    it "shows all the order's user name"  do 
      click_link("Orders")
      user_1.orders.each do |order|
        expect(page).to have_content(order.user.name)
      end
    end
  end

  describe "mark orders as completed" do 

    it "marks the order as completed" do 
      click_link("Orders")
      click_button("Complete")
      expect(page).to have_content("completed")
    end

  end
end