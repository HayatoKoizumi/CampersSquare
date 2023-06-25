class Tag < ApplicationRecord
  has_many :post_camp_tags, dependent: :destroy
  has_many :post_camps, through: :post_camp_tags

  validates :name, presence:true, length:{maximum:50}
end
