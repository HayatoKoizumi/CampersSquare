class Public::FavoritesController < ApplicationController

  def create
    post_camp = PostCamp.find(params[:post_camp_id])
    favorite = current_user.favorites.new(post_camp_id: post_camp.id)
    favorite.save
    redirect_to post_camp_path(post_camp)
  end

  def destroy
      post_camp = PostCamp.find(params[:post_camp_id])
      favorite = current_user.favorites.find_by(post_camp_id: post_camp.id)
      favorite.destroy
      redirect_to post_camp_path(post_camp)
  end
end
