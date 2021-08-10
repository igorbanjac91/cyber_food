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
      find(".orders-link").click
      user_1.orders.each do |order|
        expect(page).to have_content(order.id)
      end
    end
    
    it "shows all the order's status"  do 
      find(".orders-link").click
      user_1.orders.each do |order|
        expect(page).to have_content(order.status)
      end
    end

    it "shows all the order's food items ordered"  do 
      find(".orders-link").click
      user_1.orders.each do |order|
        order.order_items.each do |order_items|
          expect(page).to have_content(order_items.food_item.name)
        end
      end
    end


  end
end