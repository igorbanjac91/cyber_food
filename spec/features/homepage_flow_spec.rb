require "rails_helper" 

RSpec.feature "Homepage flows", type: :feature do 

  describe "homepage" do 

    let!(:user) { create(:user) }

    context "when the user is anonymous" do 
      it "renders the page with the login link" do 
        visit root_path 
        expect(page).to have_link("Log in", href: log_in_path)
      end

      it "renders the page with the sign up link" do 
        visit root_path 
        expect(page).to have_link("Sign up", href: sign_up_path)
      end
    end

    context "when the user is authenticated" do 
      
      before(:each) do 
        sign_in user
      end

      it "renders the page with the log out link" do 
        visit root_path
        expect(page).to have_link("Log out", href: log_out_path)
      end

      it "doesn't shows the log in link" do 
        visit root_path
        expect(page).to_not have_link("Log in", href: log_in_path)
      end

      it "doesn't shows the sign up link" do 
        visit root_path
        expect(page).to_not have_link("Sign up", href: sign_up_path)
      end
    end
  end
end