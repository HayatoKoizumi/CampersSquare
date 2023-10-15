class Public::FavoritesController < ApplicationController

  def create
    post_camp = PostCamp.find(params[:post_camp_id])
    @favorite = current_user.favorites.new(post_camp_id: post_camp.id)
    @favorite.save
    render 'public/favorite/replace_favorite'
  end

  def destroy
    post_camp = PostCamp.find(params[:post_camp_id])
    @favorite = current_user.favorites.find_by(post_camp_id: post_camp.id)
    @favorite.destroy
    render 'public/favorite/replace_favorite'
  end
end
