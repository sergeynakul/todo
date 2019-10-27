require 'rails_helper'

RSpec.describe TodoList, type: :model do
  subject { create :todo_list }

  it { should belong_to(:user) }
  it { should have_many(:tasks).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
end
