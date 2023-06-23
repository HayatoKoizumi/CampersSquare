class Public::PostCampsController < ApplicationController

  def new
    @post_camp = PostCamp.new
  end

  def create
    @post_camp = PostCamp.new(post_camp_params)
    @post_camp.user_id = current_user.id
    if @post_camp.save
      redirect_to post_camp_path(@post_camp), notice: "投稿が完了しました"
    else
      @post_camps = PostCamp.all
      render 'index'
    end
  end

  def show
    @post_camp = PostCamp.find(params[:id])
    #@post_camp_comment = PostCampComment.new
  end

  def index
    @post_camps = PostCamp.all
  end

  def edit
    @post_camp = PostCamp.find(params[:id])
  end

  def update
    @post_camp = PostCamp.find(params[:id])
    if @post_camp.update(post_camp_params)
      redirect_to post_camp_path(@post_camp), notice: "投稿内容を変更しました"
    else
      render "edit"
    end
  end

  def destroy
    @post_camp = PostCamp.find(params[:id])
    @post_camp.destroy
    redirect_to post_camps_path
  end

  private

  def post_camp_params
    params.require(:post_camp).permit(:title, :body, :image)
  end

  def ensure_correct_user
    @post_camp = PostCamp.find(params[:id])
    unless @post_camp.user == current_user
      redirect_to post_camps_path
    end
  end

end
