class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post_camp

  validates :comment, presence: true, length: { maximum: 100 }

end
