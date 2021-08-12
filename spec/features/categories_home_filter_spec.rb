require "rails_helper" 

RSpec.describe "categories home filter", type: :feature, js: true do 

  let!(:pizza) { create(:category, name: "Pizza") }
  let!(:pasta) { create(:category, name: "Pasta") }
  let!(:antipasti) { create(:category, name: "Antipasti") }
  let!(:drinks) { create(:category, name: "Drinks") }

  let!(:capricciose) { create(:food_item, name: "Capricciosa", category: pizza) }
  let!(:penne) { create(:food_item, name: "Penne", category: pasta) }
  let!(:bruschetta) { create(:food_item, name: "Bruschetta", category: antipasti) }
  let!(:coke) { create(:food_item, name: "Coke", category: drinks) }

  before(:each) do 
    visit root_path
  end

  describe "home page filter links" do 

    it "has a link for each category" do 
      categories = Category.all
      categories.each do |category| 
        expect(page).to have_link(category.name)
      end
    end
  end

  describe "click pizza filter" do 
    
    it "shows only the pizzas" do 
      click_link("Pizza") 
      expect(page).to have_content("Capricciosa")
      expect(page).to_not have_content("Bruschetta")
      expect(page).to_not have_content("Penne")
      expect(page).to_not have_content("Coke")
    end
  end
end