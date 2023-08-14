class AddFavTopicToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :fav_topic, :string
  end
end
