module SessionHelpers
  def sign_in_with(user) 
    visit log_in_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
  end
  
end
