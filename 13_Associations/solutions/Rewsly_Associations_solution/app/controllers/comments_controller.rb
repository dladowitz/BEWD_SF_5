class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @comment = current_user.comments.create comment_params
      redirect_to @comment.story
    else
      redirect_to new_user_session_path, alert: "Only logged in users can create comments"
    end
  end

  private 
  def comment_params
    params.require(:comment).permit(:post).merge(story_id: params[:story_id])
  end
end

