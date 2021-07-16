require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :view do
  
  it "displays all the categories" do 
    assign(:categories, [
      create(:category, name: "Pizza"),
      create(:category, name: "Drink"),
      create(:category, name: "Pasta")
    ])

    render 

    expect(rendered).to match /Pizza/
    expect(rendered).to match /Drink/
    expect(rendered).to match /Pasta/
  end
end
