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
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to admin_user_path(@user)
    else
      flash[:notice] = "ユーザー情報の更新に失敗しました"
      redirect_to edit_admin_user_path(@user)
    end
  end

  def check
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "ユーザー情報を削除しました"
    redirect_to admin_users_path
  end


  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :user_name, :email, :profile_image, :introduction, :is_deleted)
  end

end
