class UsersController < ApplicationController
  before_action :require_login, only: [:show, :update, :destroy]

  def index
    @states = State.all
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      session[:user_name] = user.first_name + ' ' + user.last_name
      redirect_to '/events'
    else
      flash[:errors] = {:first_name => user.errors[:first_name], :last_name => user.errors[:last_name], :email => user.errors[:email], :location => user.errors[:location], :state => user.errors[:state], :password => user.errors[:password], :password_confirmation => user.errors[:password_confirmation]}
      redirect_to :back
    end
  end

  def show
    @states = State.all
    @user = User.find(params[:id])
  end

  def update
    user = User.find(session[:user_id])
    if user.update(user_params)
      session[:user_name] = user.first_name + ' ' + user.last_name
      redirect_to '/events'
    else
      flash[:errors] = {:first_name => user.errors[:first_name], :last_name => user.errors[:last_name], :email => user.errors[:email], :location => user.errors[:location], :state => user.errors[:state]}
      redirect_to :back
    end
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password, :password_confirmation)
    end
end
