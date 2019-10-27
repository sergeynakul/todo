require 'rails_helper'

feature 'User can logout', "
  In order to logout
  As an authenticated user
  I'd like to be able to logout
" do
  given(:user) { create :user }

  background { visit new_user_session_path }

  scenario 'Authenticated user tries to logout' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end
