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
      categories.each_with_index do |category, n| 
        within all('.category-nav-item__link')[n] do 
          expect(page).to have_content(category.name)
        end
      end
    end
  end

  describe "click pizza link" do 
    
    it "shows only the pizzas" do 
      all('.category-nav-item__link')[0].click
      expect(page).to have_content("Capricciosa")
      expect(page).to_not have_content("Bruschetta")
      expect(page).to_not have_content("Penne")
      expect(page).to_not have_content("Coke")
    end

    it "shows only the pastas" do 
      all('.category-nav-item__link')[1].click
      expect(page).to have_content("Penne")
      expect(page).to_not have_content("Capricciosa")
      expect(page).to_not have_content("Bruschetta")
      expect(page).to_not have_content("Coke")
    end

    it "shows only the antipasti" do 
      all('.category-nav-item__link')[2].click
      expect(page).to have_content("Bruschetta")
      expect(page).to_not have_content("Capricciosa")
      expect(page).to_not have_content("Penne")
      expect(page).to_not have_content("Coke")
    end

    it "shows only the drinks" do 
      all('.category-nav-item__link')[3].click
      expect(page).to have_content("Coke")
      expect(page).to_not have_content("Capricciosa")
      expect(page).to_not have_content("Bruschetta")
      expect(page).to_not have_content("Penne")
    end
  end
end