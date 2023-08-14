class AddCategoryToPostRevisions < ActiveRecord::Migration[7.0]
  def change
    add_column :post_revisions, :category, :string
  end
end
