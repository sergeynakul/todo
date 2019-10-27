class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description, null: false
      t.datetime :expiration_time
      t.belongs_to :todo_list, foreign_key: true

      t.timestamps
    end
  end
end
