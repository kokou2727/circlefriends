class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :likes, dependent: :destroy
  validates :text, presence: true, unless: :was_attached?

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def was_attached?
    self.image.attached?
  end
end
