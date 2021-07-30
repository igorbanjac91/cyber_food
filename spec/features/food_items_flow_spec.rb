require "rails_helper"

RSpec.describe "Food Items flow", type: :feature, js: true do 

  let!(:admin_user) { create(:user, admin: true) }
  describe "food itmes page" do 

    it "shows all fhe food itmes" do 
      food_items = create_list(:food_item, 5)
      sign_in admin_user
      visit root_path
      click_link("Dashboard")
      find(".food-items-link").click
      food_items.each do |food_item| 
        expect(page).to have_content(food_item.name)
      end
    end
    
    it "add new food item" do 
      sign_in admin_user
      visit "/dashboard"
      find(".food-items-link").click
      fill_in("Name", with: "new food item")
      fill_in("Description", with: "description")
      fill_in("Price", with: "2")
      find(".submit-btn").click
      expect{ find(".submit-btn").click }.to change(FoodItem, :count).by(1)
      puts FoodItem.last.inspect
      expect(page).to have_content("new food item")
    end

  end
end