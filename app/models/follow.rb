class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :following, class_name: 'User'

  has_noticed_notifications
  after_create_commit { notify_recipient }

  def notify_recipient
    FollowNotification.with(message: self, user: following).deliver_later(following)
    broadcast_prepend_to "notifications_#{following.id}", target: "notifications_#{following.id}", partial: "notifications/follow", locals: {following:, unread: true}
  end

end
