class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  validates :first_name, :last_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :bio, length: { maximum: 150 }

  has_one_attached :avatar
  belongs_to :like
  has_many :comments
end
