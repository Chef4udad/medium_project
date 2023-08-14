class Post < ApplicationRecord
    belongs_to :user , foreign_key:'author' 
    has_many :comments, dependent: :destroy
    has_many :post_revisions, dependent: :destroy

    has_and_belongs_to_many :users_who_saved, class_name: 'User'
    validates :title ,  presence: true
end
