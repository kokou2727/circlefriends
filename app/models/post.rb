class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  validates :text, presence: true, unless: :was_attached?

  has_many :post_hashtags
  has_many :hashtags, through: :post_hashtags

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def was_attached?
    self.image.attached?
  end

  after_create do
    post = Post.find_by(id: self.id)
    hashtags  = self.text.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    post.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      post.hashtags << tag
    end
  end
end
