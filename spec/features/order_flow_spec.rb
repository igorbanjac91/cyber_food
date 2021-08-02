require "rails_helper" 

RSpec.feature "order flow", type: :feature, js: true  do 


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

    it "show a success message when a new order items is added to order" do 
      visit root_path
      find(".btn-add-to-cart").click
      expect(page).to have_content("Added item 1 to your order") 
    end
  end

  describe "log in after order creation" do 

    let!(:user) { create(:user) }

    before(:each) do 
      pizza = create(:category, name: "Pizza")
      item = create(:food_item, name: "item 1", category: pizza)
    end
    
    it "associates the order to the logged in user" do 
      visit root_path
      find(".btn-add-to-cart").click
      sign_in_with user
      expect(Order.last.user).to eq user
    end

    context "when there is already a new order" do 

      it "doesn't add a new order to new orders" do 
        order = create(:order, user: user, status: "new")
        visit root_path
        find(".btn-add-to-cart").click
        sign_in_with user
        new_orders = user.orders.where(status: 'new')
        expect(new_orders.size).to eq(1) 
      end

      it "keeps the older order" do 
        order = create(:order, user: user, status: "new")
        visit root_path
        find(".btn-add-to-cart").click
        sign_in_with user
        expect(user.new_order).to eq(order)
      end
    end
  end
end
