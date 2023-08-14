class Comment < ApplicationRecord
    belongs_to :post

    validates :post_id  , :text , presence: true

end
