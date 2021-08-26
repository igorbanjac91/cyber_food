require 'rails_helper'

RSpec.describe "Categories API", type: :request do 
  let!(:admin_user) { create(:user, admin: true) }
  let!(:user) { create(:user) }
  let!(:pizza_category) { create(:category, name: 'pizza') }


  describe "GET /index" do 

    it "return all categories" do 
      get '/api/v1/categories' 
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /show" do 
    let(:category) { create(:category) }

    it "returns a category" do 
      get "/api/v1/categories/#{category.id}"
      expect(response).to have_http_status(200)
    end
  end


  describe "POST /create" do 

    context "when the user is an administrator" do 


      context "when the params are valid" do 

        it "creates a new category" do 
          sign_in admin_user
          category_params = { category: attributes_for(:category) }
          post "/api/v1/categories", :params => category_params, headers: { "ACCEPT" => "application/json" } 
          json = JSON.parse(response.body)
          expect(response).to have_http_status(201)
        end
      end
      
      context "when the params are invalid" do 
        
        it "returns a message" do 
          sign_in admin_user
          category_params = { category: attributes_for(:category, :invalid) }
          post "/api/v1/categories", :params => category_params, headers: { "ACCEPT" => "application/json" } 
          json = JSON.parse(response.body)
          expect(response).to have_http_status(422)
        end
      end
    end

    context "when the user is authenticated but not admin" do 
      
      it "returns unauthorized" do 
        sign_in user
        category_params = { category: attributes_for(:category) }
        headers =  { "ACCEPT" => "application/json" }
        post "/api/v1/categories", :params => category_params, headers: headers
        expect(response).to have_http_status(401)
      end

    end

    context "whne the user is not authenticated" do 

      it "returns unauthorized" do 
        category_params = { category: attributes_for(:category) }
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/categories", params: category_params, headers: headers
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "PUT /update" do 
    
    context "when the user is authorized" do 

      it "return a successfull response" do 
        sign_in admin_user
        params = { category: { name: "new name"} }
        put "/api/v1/categories/#{pizza_category.id}", params: params
        expect(response).to have_http_status(200)        
      end

      it "updates the category" do 
        sign_in admin_user
        params = { category: { name: "new name"} }
        put "/api/v1/categories/#{pizza_category.id}", params: params
        update_category = Category.find(pizza_category.id)
        expect(update_category.name).to eq("new name")
      end
    end
  end

  describe "DELETE /destroy" do 

    it "return no content" do 
      sign_in admin_user
      delete "/api/v1/categories/#{pizza_category.id}"
      expect(response).to have_http_status(204)
    end

    it "deletes the category" do 
      sign_in admin_user
      expect{ delete "/api/v1/categories/#{pizza_category.id}" }.to change{Category.count}.by -1
    end
  end
end