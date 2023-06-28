class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to admin_post_camp_path(params[:post_camp_id])
  end
end
