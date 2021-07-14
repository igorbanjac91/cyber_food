require "rails_helper" 

RSpec.feature "Add order item flow", type: :feature do 

  describe "adding order item to cart" do 

    let(:food_item) { create(:food_item) }

    it "show Add To Cart button to the page" do 
      visit root_path
      expect(page).to have_button("Add to Cart")
    end
      
    xit 'add a new order itme to the cart' do 
      visit root_path
      click_button "Add To Cart"
    end
  end

end