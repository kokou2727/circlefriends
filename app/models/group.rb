class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users, dependent: :destroy
  has_many :chats, dependent: :destroy
  validates :group_name, presence: true, uniqueness: true

  has_one_attached :image
end
