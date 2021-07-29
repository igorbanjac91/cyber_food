require "rails_helper"

RSpec.describe "Food Items flow", type: :feature, js: true do 

  let!(:admin_user) { create(:user, admin: true) }
  let!(:food_items) { create_list(:food_item, 5) }
  describe "food itmes page" do 

    it "shows all fhe food itmes" do 
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
      visti "/dashboard"
      find(".food-items-link").click
      fill_in("Name", with: "name")
      fill_in("Description", with: "description")
      fill_in("Price", with: "2")
    end

  end
end