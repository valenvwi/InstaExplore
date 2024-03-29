class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  validates :first_name, :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :username, presence: true, uniqueness: true, length: { in: 4..18 }
  validates :bio, length: { maximum: 100 }
  validates :email, uniqueness: true, format: Devise.email_regexp

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :avatar
  belongs_to :like, optional: true
  has_many :comments, dependent: :destroy

  has_many :follows_as_follower, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
  has_many :follows_as_following, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy

  has_many :chatrooms_as_owner, class_name: 'Chatroom', foreign_key: :user_id, dependent: :destroy
  has_many :chatrooms_as_guest, class_name: 'Chatroom', foreign_key: :user_id, dependent: :destroy
end
