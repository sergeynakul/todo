require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:todo_lists) }

  describe '#author?' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
    let(:todo_list) { create(:todo_list, user: user) }

    it 'check user is author of todo list' do
      expect(user).to be_author(todo_list)
    end

    it 'check user is not author of todo list' do
      expect(other_user).to_not be_author(todo_list)
    end
  end
end
