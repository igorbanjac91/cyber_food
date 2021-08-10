require "rails_helper"

RSpec.describe "dashboard", type: :feature, js: true do 

  let!(:admin) { create(:user, admin: true) }

  before(:each) do 
    sign_in admin
    visit root_path
  end

  describe "home page" do 

    it "shows the Food Items link" do 
      expect(page).to have_link("Food Items")
    end

    it "shows the Categories link" do 
      expect(page).to have_link("Categories")
    end

    it "shows the Orders link" do 
      expect(page).to have_link("Orders")
    end
  end
  
  before(:each) do 
    sign_in admin
    visit root_path
  end

  describe "food itmes page" do 

    it "shows all fhe food itmes" do 
      food_items = create_list(:food_item, 5)
      click_link("Food Items")
      food_items.each do |food_item| 
        expect(page).to have_content(food_item.name)
      end
    end
    
    it "add new food item" do 
      click_link("Food Items")
      fill_in("Name", with: "new food item")
      fill_in("Description", with: "description")
      fill_in("Price", with: "2")
      click_button("Add Food Item")
      expect(page).to have_content("new food item")
    end
  end

  describe "categories items page" do 

    it "shows all the categories" do 
      pizza = create(:category, name: "Pizza")
      main = create(:category, name: "Main")
      click_link("Categories")
      expect(page).to have_content("Pizza")
      expect(page).to have_content("Main")
    end
    
    it "adds a new category" do 
      click_link("Categories")
      fill_in("Name", with: "Pasta")
      click_button("Add Category")
      expect(page).to have_content("Pasta")
    end
  end
end