require 'rails_helper'

feature 'User can register', "
  In order to login
  As an unregistered user
  I'd like to be able to register
" do
  background { visit new_user_registration_path }

  scenario 'with valid attributes' do
    fill_in 'Email', with: 'test@mail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'with invalid attributes' do
    click_on 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end
