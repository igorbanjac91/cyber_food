require "rails_helper"

RSpec.describe "admin flow", type: :feature, js: true do 

  let!(:admin) { create(:user, admin: true) }

  before(:each) do 
    sign_in admin
  end

  describe "home page" do 

    describe "dashboard nav bar" do 

      it "shows the food items link" do 
        visit root_path
        expect(page).to have_link("Dashboard", href: "/dashboard")
      end
    end
  end
end