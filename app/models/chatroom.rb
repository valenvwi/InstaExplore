class Chatroom < ApplicationRecord
  has_many :messages, dependent: :destroy

  belongs_to :owner, class_name: 'User'
  belongs_to :guest, class_name: 'User'
end
