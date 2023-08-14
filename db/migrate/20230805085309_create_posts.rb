class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author
      t.string :img
      t.string :title
      t.integer :no_of_likes ,default: 0
      t.string :category

      t.timestamps
    end
  end
end
