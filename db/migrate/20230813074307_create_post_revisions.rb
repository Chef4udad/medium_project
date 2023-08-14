class CreatePostRevisions < ActiveRecord::Migration[7.0]
  def change
    create_table :post_revisions do |t|
      t.references :post, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.datetime :edited_at

      t.timestamps
    end
  end
end
