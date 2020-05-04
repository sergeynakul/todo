require 'rails_helper'

feature 'User can create task', "
  In order to fill in the todo list
  as user
  I'd like to be able to create task
" do
  given(:user) { create :user }
  given(:todo_list) { create(:todo_list, user: user) }

  describe 'Authenticated user tries to create task', js: true do
    background do
      login(user)

      visit todo_list_path(todo_list)
    end

    scenario 'with valid attributes' do
      fill_in 'Description', with: 'Test Description'
      click_on 'Create Task'

      expect(page).to have_content 'Task successfully created.'
      expect(page).to have_content 'Test Description'
    end

    scenario 'with invalid attributes' do
      fill_in 'Description', with: ''
      click_on 'Create Task'

      expect(page).to have_content "Description can't be blank"
    end
  end

  scenario 'Unauthenticated user can not create task', js: true do
    visit todo_list_path(todo_list)

    expect(page).to_not have_link 'Create Task'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
