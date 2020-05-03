class Task < ApplicationRecord
  belongs_to :todo_list

  validates :description, presence: true, uniqueness: { scope: :todo_list_id }

  default_scope { order(expiration_time: :asc) }
end
