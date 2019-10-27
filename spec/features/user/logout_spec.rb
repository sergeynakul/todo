require 'rails_helper'

feature 'User can logout', "
  In order to logout
  As an authenticated user
  I'd like to be able to logout
" do
  given(:user) { create :user }

  background { login(user) }

  scenario 'Authenticated user tries to logout' do
    click_on 'Logout'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
