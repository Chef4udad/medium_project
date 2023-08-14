class SetDefaultvalues < ActiveRecord::Migration[7.0]
  def change
    change_column :posts, :no_of_likes , :integer ,default: 0
    change_column :posts, :title, :string , default: ''
    change_column :posts, :category,  :string , default: ''

  end
end
