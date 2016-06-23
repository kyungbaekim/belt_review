class SessionsController < ApplicationController
  def create
    user = User.find_by(:email => params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      session[:user_name] = user.first_name + ' ' + user.last_name
      redirect_to '/events'
    else
      flash[:error] = "Invalid email or password"
      redirect_to :back
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:user_name)
    redirect_to :root
  end
end
