require "rails_helper" 

RSpec.feature "order item flow", type: :feature, js: true  do 


  describe "adding order items to order" do 

    let!(:user) { create(:user) }
    context "when the user is a signed in" do 

      before(:each) do 
        pizza = create(:category, name: "Pizza")
        item = create(:food_item, name: "item 1", category: pizza)
      end
      
      it 'add a new order itme an go to the cart' do 
        sign_in user
        visit root_path
        find(".btn-add-to-cart").click
        find(".fa-shopping-cart").click
        expect(current_path).to eq("orders/#{Order.last.id}")
        # visit "/orders/#{Order.last.id}"
        expect(page).to have_content("item 1")
        expect(page).to have_content("1")
        expect(page).to have_button("Pay")
      end
    end
  end

end
