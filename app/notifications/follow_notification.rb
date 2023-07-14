class FollowNotification < Noticed::Base

  deliver_by :action_cable

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
