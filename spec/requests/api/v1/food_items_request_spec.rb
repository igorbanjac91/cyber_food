require "rails_helper"

RSpec.describe "food items API", type: :request do 

  let!(:pizza_category) { create(:category, name: "pizza") }
  let!(:drink_category) { create(:category, name: "drink") }
  let!(:pizza_julietta) { create(:food_item, name: "juilietta", description: "good pizza", price: "2000", category_id: pizza_category.id)}
  
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
          food_item_params = { food_item: attributes_for(:food_item, category_id: pizza_category.id) }
          headers = { "ACCEPT" => "application/json" }
          post "/api/v1/food_items", params: food_item_params, headers: headers
          expect(response).to have_http_status(201)
        end

        context "when the category is also passed as argument" do 
          
          it "associates that category to the food item" do
            sign_in admin_user
            params = { food_item: { 
              name: "name",
              description: "description",
              price: "5000",
              image: Rack::Test::UploadedFile.new('app/assets/images/database_seed/all.jpg', 'image/jpg'),
              category_id: pizza_category.id
            }}
            headers = { "ACCEPT" => "application/json" }
            post "/api/v1/food_items", params: params, headers: headers
            category = FoodItem.last.category
            expect(category.name).to eq("pizza")
          end
        end
      end
      
      context "when the attributes are invalid" do 
        
        it "reutrns unporcessable entity" do 
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


  describe "PUT /update" do 
    let(:admin_user) { create(:user, admin: true) }
    let(:user) { create(:user) }

    context "when the user is authorized" do 

      it "updates teh food item values" do 
        sign_in admin_user
        params = { food_item: { 
          name: "new name",
          description: "new description",
          price: "5000",
          image: Rack::Test::UploadedFile.new('app/assets/images/database_seed/all.jpg', 'image/jpg'),
          category_id: drink_category.id
        }}
        put "/api/v1/food_items/#{pizza_julietta.id}", params: params
        updated_item = FoodItem.last
        expect(updated_item.name).to eq("new name")
        expect(updated_item.description).to eq("new description")
        expect(updated_item.price).to eq(5000)
        expect(updated_item.category_id).to eq(drink_category.id)
      end
    end
  end

  describe "DELETE /destroy" do 
    let(:admin_user) { create(:user, admin: true) }

    context "when the user is authroized" do 

      it "returns no content" do 
        sign_in admin_user
        delete "/api/v1/food_items/#{pizza_julietta.id}"
        expect(response).to have_http_status(204)
      end

      it "deletes the food item" do 
        sign_in admin_user
        expect{delete "/api/v1/food_items/#{pizza_julietta.id}"}.to change{ FoodItem.count }.by -1
      end
    end
  end
end