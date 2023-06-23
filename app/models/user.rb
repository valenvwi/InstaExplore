class User < ApplicationRecord
  has_many :posts
  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :bio, length: { maximum: 50 }

  has_one_attached :avatar
end
