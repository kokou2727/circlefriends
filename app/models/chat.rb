class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :group
  has_one_attached :image

  validates :message, presence: true
end
