require "rails_helper" 

RSpec.describe "user flow", type: :feature, js: true do 

  let!(:user) { user_with_completed_orders }

  before(:each) do 
    sign_in user
    visit root_path
  end
  
  describe "show old orders" do

    it "shows old completed orders" do 
      page.find('.fa-bars').click
      click_link("Orders")
      user.orders.each do |order| 
        expect(page).to have_content(order.id)
      end
    end
  end
end