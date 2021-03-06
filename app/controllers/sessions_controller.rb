class SessionsController < ApplicationController

  def create
    twitter_nickname = request.env['omniauth.auth']['info']['nickname']
    user = User.where(:username => twitter_nickname).first

    if user.present?
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      user_info = User.parse_user_info(request.env['omniauth.auth'])
      session[:user_info] = user_info

      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def home
    render layout: 'full_screen_photo_page'
  end
end



