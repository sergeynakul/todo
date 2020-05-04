require 'rails_helper'

feature 'User can edit task', "
  In order to correct mistakes
  As an author a task
  I'd like to be able edit my task
" do
  given(:user) { create(:user) }
  given(:other_user) { create(:user) }
  given(:todo_list) { create(:todo_list, user: user) }
  given!(:task) { create(:task, todo_list: todo_list) }

  scenario 'Unauthenticated user can not edit task', js: true do
    visit todo_list_path(todo_list)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Authenticated user', js: true do
    background do
      login(user)
      visit todo_list_path(todo_list)

      click_on 'Edit'
    end

    scenario 'edits his task' do
      within('.task') do
        fill_in 'Description', with: 'edited description'
        click_on 'Update Task'

        expect(page).to_not have_content task.description
        expect(page).to have_content 'edited description'
      end
    end

    scenario 'edits his task with errors' do
      within('.task') do
        fill_in 'Description', with: ''
        click_on 'Update Task'

        expect(page).to have_content "Description can't be blank"
      end
    end

    scenario "tries to edit other user's task" do
      click_on 'Logout'
      login(other_user)
      visit todo_list_path(todo_list)

      expect(page).to_not have_link 'Edit'
    end
  end
end
