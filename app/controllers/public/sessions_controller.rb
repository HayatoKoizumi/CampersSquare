# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  def after_sign_in_path_for(resource)
    flash[:notice] = "ようこそ「#{@user.user_name}」さん"
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice] = "ログアウトしました"
    root_path
  end


  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "ゲストユーザーとしてログインしました。"
  end


  protected

  # 退会していることを判断するためのメソッド
  def user_state
    # ユーザーの登録されたemailを取得
    @user = User.find_by(email: params[:user][:email])
    # アカウント取得失敗の場合は、このメソッドを終了する
    return if !@user
    # 取得したアカウントのパスワードと入力されたパスワードの一致確認
    if @user.valid_password?(params[:user][:password]) && ( @user.is_deleted == true )
      flash[:notice] = "退会済みです。再度ご登録してご利用ください。"
      redirect_to new_user_registration_path
    else
      flash[:notice] = "該当するユーザーが見つかりません。再度、項目を入力してください。"
    end
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
