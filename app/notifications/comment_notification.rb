class CommentNotification < Noticed::Base
  deliver_by :database

  def comment
    params[:message]
  end

  def creator
    comment.nil? ? "Someone" : comment.user
  end

  def post
    comment.nil? ? "your post" : comment.post
  end

  def url
    post_path(params[:post])
  end
end
