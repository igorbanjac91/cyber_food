require "rails_helper" 

RSpec.feature "order item flow", type: :feature, js: true  do 


  describe "adding order items to order" do 

    context "when the user is a guest" do 

      before(:each) do 
        pizza = create(:category, name: "Pizza")
        item = create(:food_item, name: "item 1", category: pizza)
      end
      
      xit "creates a new order when clicking Add To Cart" do 
        visit root_path
        expect{ click_button("Add To Cart") }.to change(Order, :count).by(1)
      end
      
      it 'add a new order itme an go to the cart' do 
        visit root_path
        click_button("Add To Cart")
        find(".fa-shopping-cart").click
        expect(current_path).to eq("orders/#{Order.last.id}")
        expect(page).to have_content("item 1")
        expect(page).to have_content("1")
        expect(page).to have_button("Pay")
      end
    end
  end

end
