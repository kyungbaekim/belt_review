class EventsController < ApplicationController
  before_action :require_login, only: [:index, :create, :edit, :destroy]

  def index
    @events = Event.all
    @user = User.find(session[:user_id])
    @states = State.all
  end

  def create
    event = Event.new(event_params)
    if params[:event][:event_date] == '' || params[:event][:event_date].to_date.past?
      flash[:error] = 'Event date cannot be past date or empty!'
    else
      if event.save
        # do nothing
      else
        flash[:errors] = {:name => event.errors[:name], :date => event.errors[:date], :location => event.errors[:location], :state => event.errors[:state]}
      end
    end
    redirect_to action: 'index'
  end

  def show
    @event = Event.includes(:user).find(params[:id])
    @comments = Comment.includes(:user).where(event_id: params[:id])
  end

  def edit
    @event = Event.includes(:user).find(params[:id])
    @states = State.all
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      # do nothing
    else
      flash[:errors] = {:name => event.errors[:name], :date => event.errors[:date], :location => event.errors[:location], :state => event.errors[:state]}
    end
    redirect_to '/events'
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy if event.user == current_user
    redirect_to '/events'
  end

  private
    def event_params
      params.require(:event).permit(:event_name, :event_date, :event_location, :event_state, :user_id)
    end
end
