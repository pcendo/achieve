class FavoritesController < ApplicationController
  before_action :authenticate_user, only: [:index]

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(blog_id: params[:blog_id]).destroy
    redirect_to blogs_path, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end
  
  def index
    @favorites_blogs = current_user.favorite_blogs
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
  
  def authenticate_user
    if logged_in?
    else
      redirect_to new_session_path
    end
  end
  
end