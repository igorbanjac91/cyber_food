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
      expect(page).to have_button("Checkout")
      expect(page).to have_link("Back To Menu")
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

  describe "adding quantities to and order item " do 

    let!(:user) { user_with_order }

    before(:each) do 
      sign_in_with user
      order = user.new_order
      pizza = create(:category, name: "Pizza")
      margherita = create(:food_item, name: "Margherita", category: pizza)
      create(:order_item, order: order, food_item:  margherita, quantity: 2)
    end

    describe "click the plus button" do 
      
      it "increases the qunatity by 1" do 
        visit "/orders/#{user.new_order.id}"
        find(".plus-btn").click
        within(".cart-table__quantity") do 
          expect(page).to have_content("3")
        end
      end
    end

    describe "click the minus button" do 

      context "when the quntity is higher then 1" do 

        it "decreases the quntity by 1" do 
          visit "/orders/#{user.new_order.id}"
          find(".minus-btn").click
          within(".cart-table__quantity") do 
            expect(page).to have_content("1")
          end
        end
      end

      context "when the quntity is 1" do 

        it "removes the order item from the cart" do 
          visit "/orders/#{user.new_order.id}"
          find(".minus-btn").click
          find(".minus-btn").click
          expect(page).to_not have_content("Margherita")
        end
      end
    end

  end
end
