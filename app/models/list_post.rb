class ListPost < ApplicationRecord
  belongs_to :list
  belongs_to :post
end
