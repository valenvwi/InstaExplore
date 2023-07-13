class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  # before_validation :set_default_avatar, on: :create
  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true, length:{ maximum: 18 }
  validates :bio, length: { maximum: 100 }

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_one_attached :avatar
  belongs_to :like, optional: true
  has_many :comments, dependent: :destroy

  has_many :follows_as_follower, foreign_key: :follower_id, class_name: 'Follow'
  has_many :follows_as_following, foreign_key: :following_id, class_name: 'Follow'

  has_many :notifications, as: :recipient, dependent: :destroy

  private

  # def set_default_avatar
  #   self.avatar = "https://res.cloudinary.com/duq6yxlzy/image/upload/v1/development/ltjpdg0x26bhr6ylcphyygo1fi88"
  # end
end
