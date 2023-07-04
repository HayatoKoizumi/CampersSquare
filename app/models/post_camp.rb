class PostCamp < ApplicationRecord

  has_one_attached :image

  belongs_to :user

  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :post_camp_tags, dependent: :destroy
  has_many :tags, through: :post_camp_tags
  
  has_many :vision_tags, dependent: :destroy

  #validates  :image, presence:  true
  validates  :title, presence:  true, length: { maximum: 20 }
  validates  :body, presence:  true, length: { maximum: 300 }

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def favorited_by?(user)
   favorites.exists?(user_id: user.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "title"]
  end

  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end

end
