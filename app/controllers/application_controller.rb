class ApplicationController < ActionController::Base
  before_action :search

  def search
    @q = params[:q]

    @post_camp = PostCamp.ransack(title_cont: @q).result
    @user = User.ransack(user_name_cont: @q).result

    # @result = params[:q]&.values&.reject(&:blank?)
  end
end
