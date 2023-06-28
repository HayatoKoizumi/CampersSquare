class Admin::CommentsController < ApplicationController
  def destroy
    Comment.find(params[:id]).destroy
    flash[:notice] = "コメントを削除しました"
    redirect_to request.referer
  end
end
