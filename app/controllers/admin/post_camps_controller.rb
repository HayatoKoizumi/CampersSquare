class Admin::PostCampsController < ApplicationController
  before_action :authenticate_admin!

  def show
    @post_camp = PostCamp.find(params[:id])
    @comment = Comment.new
    @user = @post_camp.user
  end

  def index
    @post_camps = PostCamp.all.order(updated_at: :desc).page(params[:page]).per(5)
  end

  def destroy
    @post_camp = PostCamp.find(params[:id])
    @post_camp.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to admin_post_camps_path
  end

  private

  def post_camp_params
    params.require(:post_camp).permit(:title, :body, :image)
  end

end