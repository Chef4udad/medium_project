class ChangeimgType < ActiveRecord::Migration[7.0]
  def change
    change_column :users , :img , :string
  end
end
