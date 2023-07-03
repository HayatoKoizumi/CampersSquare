class Public::PostCampsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post_camp = PostCamp.new
  end

  def create
    @post_camp = PostCamp.new(post_camp_params)
    vision_tags = Vision.get_image_data(post_camp_params[:image])
    @post_camp.user_id = current_user.id
    # 受け取った値を,で区切って配列にする
    tag_list = params[:post_camp][:name].split(',')
    if @post_camp.save
      vision_tags.each do |vision_tag|
        @post_camp.vision_tags.create(name: vision_tag)
      end
      @post_camp.save_tags(tag_list)
      redirect_to post_camp_path(@post_camp), notice: "投稿が完了しました"
    else
      flash[:notice] = "投稿を作成できませんでした"
      render 'new'
    end
  end

  def show
    @post_camp = PostCamp.find(params[:id])
    @comment = Comment.new
    @user = @post_camp.user
    @tag_list = @post_camp.tags.pluck(:name).join(',')
    @post_camp_tags = @post_camp.tags
  end

  def index
    @post_camps = PostCamp.all.order(updated_at: :desc).page(params[:page]).per(5)
    @tag_list = Tag.all
  end

  def edit
    @post_camp = PostCamp.find(params[:id])
    @tag_list = @post_camp.tags.pluck(:name).join(',')
  end

  def update
    @post_camp = PostCamp.find(params[:id])
    tag_list=params[:post_camp][:name].split(',')
    if @post_camp.update(post_camp_params)
      @post_camp.save_tags(tag_list)
      redirect_to post_camp_path(@post_camp), notice: "投稿内容を更新しました"
    else
      flash[:notice] = "投稿内容を更新できませんでした"
      render "edit"
    end
  end

  def destroy
    @post_camp = PostCamp.find(params[:id])
    @post_camp.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to post_camps_path
  end

  def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list = Tag.all
    #検索されたタグを受け取る
    @tag = Tag.find(params[:tag_id])
    #検索されたタグに紐づく投稿を表示
    @post_camps = @tag.post_camps.page(params[:page]).per(5)
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
