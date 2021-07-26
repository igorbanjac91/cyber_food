require "rails_helper" 

RSpec.feature "Add order item flow", type: :feature, js: true do 

  describe "adding order item to cart" do 

    before(:each) do 
      pizza = create(:category, name: "Pizza")
      create(:food_item, name: "item 1", category: pizza)
    end

    it "renders the Add To Cart button for each food item" do 
      visit root_path
      expect(page).to have_button("Add To Cart")
    end
      
    it 'add a new order itme to the cart' do 
      visit root_path
      click_button "Add To Cart"
      page.find(".fa-shopping-cart").click
      expect(current_path).to eq("orders/#{Order.last.id}")
      expect(page).to have_content("item 1")
      expect(page).to have_content("1")
      expect(page).to have_button("Pay")
    end
  end

end