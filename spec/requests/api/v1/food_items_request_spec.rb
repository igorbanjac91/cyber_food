require "rails_helper"

RSpec.describe "food items API", type: :request do 

  describe "GET /index" do 

    it "return all food items" do 
      get "/api/v1/food_items"
      expect(response).to have_http_status(200)
    end
  end


  describe "GET /show" do 

    let(:food_item) { create(:food_item) }

    it "returns a specific food item" do 
      get "/api/v1/food_items/#{food_item.id}"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /create" do 
    let(:admin_user) { create(:user, admin: true) }
    let(:user) { create(:user) }
            
    context "when the user is an administrator" do 
  
      context "when the attributes are valid" do 
        
        it "crates a new food item" do 
          sign_in admin_user
          food_item_params = { food_item: attributes_for(:food_item) }
          headers = { "ACCEPT" => "application/json" }
          post "/api/v1/food_items", params: food_item_params, headers: headers
          expect(response).to have_http_status(201)
        end
      end
      
      context "when the attributes are invalid" do 
        
        it "doesn't create a new food item" do 
          sign_in admin_user
          food_item_params = { food_item: attributes_for(:food_item, :invalid) }
          headers = { "ACCEPT" => "application/json" }
          post "/api/v1/food_items", params: food_item_params, headers: headers
          expect(response).to have_http_status(422)
        end
      end
    end
    
    context "when the user is authenticated but not admin" do 
      
      it "return unhautorized" do 
        sign_in user
        food_item_params = { food_item: attributes_for(:food_item) }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/food_items", params: food_item_params, headers: headers
        expect(response).to have_http_status(401)
      end
    end
    
    context "whne the user is not authenticated" do 
      
      it "return unhautorized" do 
        food_item_params = { food_item: attributes_for(:food_item) }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/food_items", params: food_item_params, headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

end