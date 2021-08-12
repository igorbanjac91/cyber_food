require "rails_helper"

RSpec.describe "Orders API" do 

  let!(:admin_user) { create(:user, admin: true) }
  let!(:user_1_with_orders) { user_with_new_orders }
  let!(:other_user_with_orders) { user_with_new_orders }
  let!(:user) { user_with_ordered_order }
          
  describe "GET /index" do 

    context "when the user is an admin" do 

      it "returns all the orders" do 
        sign_in admin_user
        get "/api/v1/orders" 
        expect(response).to have_http_status(200)
      end
    end
    
    context "when the user is authenticated" do 
      
      it "returns the user's orders with order itmes" do 
        sign_in user_1_with_orders
        get "/api/v1/orders" 
        expect(response).to have_http_status(200)
        JSON.parse(response.body).each do |elm|
          expect(elm["user_id"]).to eq user_1_with_orders.id
        end
      end
      
      it "doesn't return other usrs's orders" do 
        sign_in other_user_with_orders
        get "/api/v1/orders" 
        expect(response).to have_http_status(200)
        JSON.parse(response.body).each do |elm|
          expect(elm["user_id"]).to_not eq user_1_with_orders.id
        end
      end
    end

    context "whehn the user isn't authenticated" do 

      it "returns unauthorized" do 
        get "/api/v1/orders" 
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET /show" do 

    context "when the user is an admin" do 

      it "returns order" do 
        sign_in admin_user
        order = user_1_with_orders.orders.first
        get "/api/v1/orders/#{order.id}"
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["id"]).to eq(order.id)
      end
    end

    context "when the user is authenticated" do 
      
      it "returns the user's order" do 
        sign_in user_1_with_orders
        order = user_1_with_orders.orders.first
        get "/api/v1/orders/#{order.id}"
        expect(response).to have_http_status(200)
      end

      it "doesn't return other user's order" do 
        sign_in user_1_with_orders
        other_user_order = other_user_with_orders.orders.first
        get "/api/v1/orders/#{other_user_order.id}"
        expect(response).to have_http_status(401)
      end
    end

    context "whehn the user isn't authenticated" do 

      it "return unauthorized" do 
        order = user_1_with_orders.orders.first
        get "/api/v1/orders/#{order.id}"
        expect(response).to have_http_status(401)
      end
    end
  end
  
  describe "PUT /update" do 

    context "when the user is authenticated" do 

      it "returns an order" do 
        sign_in admin_user
        order = user.orders[0]
        params = { order: { status: "completed"} }
        put "/api/v1/orders/#{order.id}", params: params
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["status"]).to eq("completed")
      end
    end
  end
end