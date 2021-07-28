require "rails_helper"

RSpec.describe "order items API", type: :request do 

  let!(:adim_user) { create(:user, admin: true) }
  let!(:user) { create(:user) }
  let!(:user_2) { create(:user) }
  let!(:food_items) { category_with_food_items.food_items }

  describe "POST /create" do 

    context "when is an adim user" do 
      
      it "cannot create order_items" do 
        sign_in adim_user
        order = create(:order, user: user)
        order_items_params = { order_item:  { quantity: 1, food_item: food_items[0] } }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/order_items", params: order_items_params, headers: headers
        expect(response).to have_http_status(401)
      end
    end

    context "when is an authenticated user" do 

      it "can create only order items for his order" do 
        sign_in user
        order_items_params = { order_item:  { quantity: 1, food_item_id: food_items[0].id } }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/order_items", params: order_items_params, headers: headers
        expect(response).to have_http_status(200)
      end
    end
  end

end