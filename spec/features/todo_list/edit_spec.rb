require 'rails_helper'

feature 'User can edit todo list', "
  In order to correct mistakes
  As an author a todo list
  I'd like to be able edit my todo list
" do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given!(:todo_list) { create(:todo_list, user: user) }

  scenario 'Unauthenticated user can not edit todo list' do
    visit todo_lists_path

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user' do
    background do
      login(user)
      visit todo_lists_path

      click_on 'Edit'
    end

    scenario 'edits his todo list' do
      fill_in 'Title', with: 'edited title'
      click_on 'Update Todo list'

      expect(page).to_not have_content todo_list.title
      expect(page).to have_content 'edited title'
    end

    scenario 'edits his todo list with errors' do
      fill_in 'Title', with: ''
      click_on 'Update Todo list'

      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario "Authenticated user tries to edit other user's todo list" do
    login(other_user)
    visit todo_lists_path

    expect(page).to_not have_link 'Edit'
  end
end
