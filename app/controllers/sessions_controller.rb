class SessionsController < ApplicationController
  before_action :authenticate_user, only: [:new ]

  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:danger] = 'ログインに失敗しました'
      redirect_to new_session_path
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
  
  private
  def authenticate_user
    if logged_in?
      redirect_to session_path(current_user.id)
    else
    end
  end
  
end
