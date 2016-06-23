class JoinsController < ApplicationController
  def create
    join = Join.create(event_id: params[:event_id], user_id: session[:user_id])
    redirect_to '/events'
  end

  def destroy
    join = Join.find(params[:id])
    join.destroy if join.user == current_user
    redirect_to '/events'
  end
end
