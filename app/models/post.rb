class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :images, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
end
