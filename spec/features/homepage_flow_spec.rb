require "rails_helper" 

RSpec.feature "Homepage flows", type: :feature, js: true do 

  let!(:user) { create(:user)}

  describe "homepage" do 

    describe "cart icon" do

      before(:each) do 
        visit root_path
      end

      it "is on the homepage" do 
        expect(page).to have_selector(".main-header__cart-icon")
      end

      context "when there is no order itmes in the cart" do 

        it "doesn't link anywhere" do 
          page.find(".main-header__cart-icon").click
          expect(current_path).to eq root_path
        end
      end
    end
    
    before(:each) do
      create(:category, name: "Pizza" )
      create(:category, name: "Pasta" ) 
      create(:category, name: "Drinks" ) 
      create(:food_item, name: "item 1", category: create(:category, name: "new category"))
    end
  
    it "shows all categories" do 
      expect(page).to have_content("Pizza")
      expect(page).to have_content("Pasta")
      expect(page).to have_content("Drinks")
    end

    it "renders the Add To Cart button for each food item" do 
      visit root_path
      expect(page).to have_button("Add To Cart")
    end

    it "has a link to orders for logged in users" do 
      sign_in user
      visit root_path
      page.find('.fa-bars').click
      expect(page).to have_link("Orders")
    end

    context "when the user is anonymous" do 

      before(:each) do 
        visit root_path
      end

      it "renders the page with the login link" do 
        page.find('.fa-bars').click
        expect(page).to have_link("Log in", href: log_in_path)
      end
      
      it "renders the page with the sign up link" do 
        page.find('.fa-bars').click
        expect(page).to have_link("Sign up", href: sign_up_path)
      end
    end
    
    context "when the user is authenticated" do 
      
      
      before(:each) do 
        @user = create(:user)
        sign_in @user
        visit root_path
      end
      
      it "renders the page with the log out link" do 
        page.find('.fa-bars').click
        expect(page).to have_link("Log out", href: log_out_path)
      end

      it "doesn't shows the log in link" do 
        page.find('.fa-bars').click
        expect(page).to_not have_link("Log in", href: log_in_path)
      end

      it "doesn't shows the sign up link" do 
        page.find('.fa-bars').click
        expect(page).to_not have_link("Sign up", href: sign_up_path)
      end
    end
  end
end