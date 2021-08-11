require "rails_helper"

RSpec.describe "dashboard", type: :feature, js: true do 

  let!(:admin) { create(:user, admin: true) }
  let!(:food_items) { create_list(:food_item, 5) }

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
      click_link("Food Items")
      food_items.each do |food_item| 
        expect(page).to have_content(food_item.name)
      end
    end
    
    describe "actions" do 

      it "adds new food item" do 
        click_link("Food Items")
        fill_in("Name", with: "new food item")
        fill_in("Description", with: "description")
        fill_in("Price", with: "2")
        attach_file('food_item[image]', './app/assets/images/database_seed/dark.jpg')
        click_button("Add Food Item")
        expect(page).to have_content("new food item")
      end

      it "modifies an existing food item" do 
        click_link("Food Items")
        find(".edit-btn", match: :first).click
        fill_in("Name", with: "New name")
        fill_in("Description", with: "New description")
        fill_in("Price", with: "999")
        click_button("Edit Food Item")
        expect(page).to have_content("New name")
        expect(page).to have_content("New description")
        expect(page).to have_content("999")
      end
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