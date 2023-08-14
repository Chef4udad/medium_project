class List < ApplicationRecord
    belongs_to :user
    has_many :list_posts, dependent: :destroy
    has_many :posts, through: :list_posts
    has_and_belongs_to_many :shared_users, class_name: 'User', join_table: 'lists_users'
end
