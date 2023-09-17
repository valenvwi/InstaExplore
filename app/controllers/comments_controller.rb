class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user
    authorize @post

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path(@post) }
      else
        format.html { render partial: "comments/form", locals: { post: @post, comment: @comment }, status: :unprocessable_entity }
      end
      format.json
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
