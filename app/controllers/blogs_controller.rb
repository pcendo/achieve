class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user, only: [:new, :edit, :show, :index]
  before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id
    @blog.image.retrieve_from_cache! params[:cache][:image]

    if @blog.save
      BlogMailer.blog_mail(@blog).deliver
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end
  
  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end
  
  def edit
  end
  
  def update
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id, :image)
  end
  
  def set_blog
    @blog = Blog.find(params[:id])
  end
  
  def authenticate_user
    if logged_in?
    else
      redirect_to new_session_path
    end
  end

  def ensure_correct_user
    @blog = Blog.find_by(id: params[:id])
    if @current_user.id != @blog.user_id
      flash[:notice] = "編集の権限がありません"
      redirect_to blogs_path
    end
  end
  
end
