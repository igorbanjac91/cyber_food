require "rails_helper"

RSpec.describe "order items API", type: :request do 

  let!(:adim_user) { create(:user, admin: true) }
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:order) { create(:order, user: user) }
  let!(:order_2) { create(:order, user: user_2) }
  let!(:food_items) { category_with_food_items.food_items }
  let!(:order_item) { create(:order_item, quantity: 1, food_item: food_items[0], order: order)}
  let!(:order_item_2) { create(:order_item, quantity: 1, food_item: food_items[0], order: order_2)}

  describe "POST /create" do 

    context "when is an authenticated user" do 

      it "cretes a new order item" do 
        sign_in user
        order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/order_items", params: order_items_params, headers: headers
        expect(response).to have_http_status(201)
      end
      
      it "creates a new order for the order items if not already created" do 
        sign_in user
        order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
        headers = { "ACCEPT" => "application/json" }
        expect {post "/api/v1/order_items", params: order_items_params, headers: headers}.to change(Order, :count).by(1)
        expect(response).to have_http_status(201)
      end
    end

    context "when the user is unauthenticated" do 
    
      it "creates a user guest associated with a new order" do 
        order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/order_items", params: order_items_params, headers: headers
        expect(Order.last.user.guest).to be true
      end

    end

    context "for every user" do 

      context "when the is a new food item" do 

        it "sets the quantity to 1" do 
          order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
          headers = { "ACCEPT" => "application/json" }
          post "/api/v1/order_items", params: order_items_params, headers: headers
          order_item = Order.last.order_items.first
          expect(order_item.quantity).to eq 1
        end
      end

      context "when the food item is the same" do 

        it "increases the quantity by 1" do 
          order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
          headers = { "ACCEPT" => "application/json" }
          post "/api/v1/order_items", params: order_items_params, headers: headers
          post "/api/v1/order_items", params: order_items_params, headers: headers
          order_item = Order.last.order_items.first
          expect(order_item.quantity).to eq 2
        end
      end
    end
  end
  
  describe "PUT /update" do 

    context "when the user is an authenticated user" do 

      context "the order item belong to the current user" do 

        it "updates the order item quantity" do 
          sign_in user
          params = { order_item: { id: order_item.id, quantity: 2 } }
          headers = { "ACCEPT" => "application/json" } 
          put "/api/v1/order_items/#{order_item.id}", params: params, headers: headers
          expect(response).to have_http_status(200)
          order_item_updated = OrderItem.find(order_item.id)
          expect(order_item_updated.quantity).to eq 2
        end
      end

      context "when the order item belongs to another user" do 

        it "returns unauthorized" do 
          sign_in user
          params = { order_item: { id: order_item_2.id, quantity: 2 } }
          headers = { "ACCEPT" => "application/json" } 
          put "/api/v1/order_items/#{order_item_2.id}", params: params, headers: headers
          expect(response).to have_http_status(401)
          order_item_updated = OrderItem.find(order_item_2.id)
          expect(order_item_updated.quantity).to eq 1
        end
      end
    end
  end

  describe "DELETE /destroy" do 

    context "when the orde items belongs to the user" do 

      it "delete the order item" do 
        sign_in user
        headers = { "ACCEPT" => "application/json" } 
        delete "/api/v1/order_items/#{order_item.id}"
        expect(response).to have_http_status(204)
        expect(order.order_items.count).to eq 0
      end
    end

    context "when teh order items belongs to another user" do 
      
      it "reutrns unauthorized and it doesn't remove the order item" do 
        sign_in user
        headers = { "ACCEPT" => "application/json" } 
        delete "/api/v1/order_items/#{order_item_2.id}"
        expect(response).to have_http_status(401)
        expect(order.order_items.count).to eq 1
      end
    end
  end


end