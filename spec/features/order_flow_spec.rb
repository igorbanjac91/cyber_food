require "rails_helper" 

RSpec.feature "order item flow", type: :feature, js: true  do 


  describe "adding order items to order" do 

    let!(:user) { create(:user) }

    before(:each) do 
      pizza = create(:category, name: "Pizza")
      item = create(:food_item, name: "item 1", category: pizza)
    end
    
    it 'add a new order itme an go to the cart' do 
      sign_in user
      visit root_path
      find(".btn-add-to-cart").click
      find(".fa-shopping-cart").click
      visit "/orders/#{Order.last.id}"        # workaround, after click doesn't load the page
      expect(page).to have_content("item 1")
      expect(page).to have_content("1")
      expect(page).to have_button("Pay")
    end

    it "show a success message when a new order items is added to order", driver: :chrome do 
      visit root_path
      find(".btn-add-to-cart").click
      expect(page).to have_content("Added item 1 to your order") 
    end
  end


 
end
