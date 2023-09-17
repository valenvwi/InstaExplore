class FollowNotification < Noticed::Base
  deliver_by :database

  def follow
    params[:message]
  end

  def creator
    follow.nil? ? "Someone" : follow.follower
  end

  def following
    follow.nil? ? "you" : follow.following
  end
end
