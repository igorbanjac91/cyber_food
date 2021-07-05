require "rails_helper" 

RSpec.feature "Add order item flow" type: :feature do 

  describe "adding order item to cart" do 

    it 'add a new order itme to the cart' do 
      visit root_path
      click_button "Add To Cart"
    end
  end

end