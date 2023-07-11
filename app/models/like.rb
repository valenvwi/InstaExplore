class Like < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :post, optional: true

  has_noticed_notifications
  after_create_commit { notify_recipient }

  def notify_recipient
    return if user == post.user
    LikeNotification.with(message: self, post: post).deliver_later(post.user)

    broadcast_prepend_to "notifications_#{post.user.id}", target: "notifications_#{post.user.id}", partial: "notifications/like", locals: {user:, post:, unread: true}
  end

end
