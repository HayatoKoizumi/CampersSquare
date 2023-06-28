class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @post_camps = @user.post_camps.order(updated_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_user_path
    else
      flash[:notice] = "ユーザー情報の更新に失敗しました"
      redirect_to edit_admin_user_path(@user)
    end
  end

  def check
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :user_name, :email, :profile_image, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
