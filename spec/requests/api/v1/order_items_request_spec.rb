require "rails_helper"

RSpec.describe "order items API", type: :request do 

  let!(:adim_user) { create(:user, admin: true) }
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:food_items) { category_with_food_items.food_items }

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

  end

end