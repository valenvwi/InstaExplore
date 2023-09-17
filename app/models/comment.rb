class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_noticed_notifications
  after_create_commit { notify_recipient }

  validates :content, length: { maximum: 300 }

  def notify_recipient
    return if user == post.user

    CommentNotification.with(message: self, post:).deliver_later(post.user)

    broadcast_prepend_to(
      "notifications_#{post.user.id}",
      target: "notifications_#{post.user.id}",
      partial: "notifications/comment",
      locals: { user:, post:, unread: true }
    )
  end
end
