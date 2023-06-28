class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_user, only: [:favorites]


  def index
    @users = User.all.order(updated_at: :desc).page(params[:page]).per(5)
    @post_camps = PostCamp.all
  end

  def show
    @user = User.find(params[:id])
    @post_camps = @user.post_camps.order(updated_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path, notice: "ユーザー情報を更新しました"
    else
      flash[:notice] = "ユーザー情報を更新できませんでした"
      render "edit"
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

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_camp_id)
    @favorite_post_camp = PostCamp.find(favorites)
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :user_name, :email, :profile_image, :introduction)
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
