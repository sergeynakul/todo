require 'rails_helper'

feature 'User can create todo list', "
  In order to plan actions
  as user
  I'd like to be able to create todo list
" do
  given(:user) { create(:user) }

  describe 'Authenticated user tries to create todo list' do
    background do
      login(user)

      visit todo_lists_path
      click_on 'Create Todo List'
    end

    scenario 'with valid attributes' do
      fill_in 'Title', with: 'Test title'
      click_on 'Create'

      expect(page).to have_content 'Todo List successfully created.'
      expect(page).to have_content 'Test title'
    end

    scenario 'with invalid attributes' do
      fill_in 'Title', with: ''
      click_on 'Create'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated user can not create todo list' do
    visit todo_lists_path

    expect(page).to_not have_link 'Create Todo List'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
