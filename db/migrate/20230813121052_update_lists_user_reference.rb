class UpdateListsUserReference < ActiveRecord::Migration[7.0]
  def change
    remove_column :lists, :user_id, :integer
    add_reference :lists, :user, foreign_key: true
  end
end
