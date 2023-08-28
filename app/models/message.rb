class Message < ApplicationRecord
  belongs_to :chatroom
  belongs_to :user


  after_create_commit { broadcast_append_to self.chatroom }
end
