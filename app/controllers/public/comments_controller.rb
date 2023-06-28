class Public::CommentsController < ApplicationController

  def create
    post_camp = PostCamp.find(params[:post_camp_id])
    comment = current_user.comments.new(comment_params)
    comment.post_camp_id = post_camp.id
    comment.save
    redirect_to post_camp_path(post_camp)
  end

  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to post_camp_path(params[:post_camp_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :post_camp_id)
  end

end