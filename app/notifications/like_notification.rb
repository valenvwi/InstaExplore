class LikeNotification < Noticed::Base
  deliver_by :action_cable
  # param :post

  def like
    params[:message]
  end

  def creator
    like.nil? ? "Someone" : like.user
  end

  def post
    like.nil? ? "your post" : like.post
  end

  def url
    post_path(params[:post])
  end
end
