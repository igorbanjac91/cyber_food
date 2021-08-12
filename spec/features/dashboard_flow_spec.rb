require "rails_helper"

RSpec.describe "dashboard", type: :feature, js: true do 

  let!(:admin) { create(:user, admin: true) }
  let!(:food_items) { create_list(:food_item, 5) }
  let!(:pizza_category) { create(:category, name: "pizza")}
  let!(:pasta_category) { create(:category, name: "pasta")}
  let!(:dirnks_category) { create(:category, name: "drink")}

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
        within ".dashboard-food-items__form", match: :first do
          fill_in("Name", with: "new food item")
          fill_in("Description", with: "new food item description")
          fill_in("Price", with: "2345")
          attach_file('food_item[image]', './app/assets/images/database_seed/dark.jpg')
          select("pizza", from: 'Category')
          click_button("Add Food Item")
        end
        expect(page).to have_content("new food item")
        expect(page).to have_content("new food item description")
        expect(page).to have_content("2345")
        expect(page).to have_content("pizza")
      end

      it "modifies an existing food item" do 
        click_link("Food Items")
        find(".edit-btn", match: :first).click
        within all(".dashboard-food-items__form")[1] do 
          fill_in("Name", with: "new name")
          fill_in("Description", with: "new description")
          fill_in("Price", with: "999")
          click_button("Edit Food Item")
        end
        expect(page).to have_content("new name")
        expect(page).to have_content("new description")
        expect(page).to have_content("999")
      end

      it "deletes an existing food item" do 
        food_item = FoodItem.find(1)
        click_link("Food Items")
        find(".delete-btn", match: :first).click
        expect(page).to_not have_content(food_item.name)
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
      within '.dashboard-categories__form', match: :first do 
        fill_in("Name", with: "Pasta")
        attach_file('category[image]', './app/assets/images/database_seed/dark.jpg')
      end
      click_button("Add Category")
      expect(page).to have_content("Pasta")
    end
    
    it "edits and existing category" do 
      pizza = create(:category, name: "Pizza")
      click_link("Categories")
      find('.edit-btn', match: :first).click
      within '.edit-form' do 
        fill_in("Name", with: "Drinks") 
      end
      click_button("Edit Category")
      expect(page).to have_content("Drinks")
    end

    it "deletes a category" do 
      pizza = create(:category, name: "New category")
      click_link("Categories")
      find('.delete-btn', match: :first).click
      expect(page).to_not have_content("New category")
    end
  end

end