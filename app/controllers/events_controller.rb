class EventsController < ApplicationController
  def show
  end

  def index
    @event = Event.new
    @user = current_user
    @events = Event.where(user_id: current_user.id)
  end

  def create
    event = Event.new(event_params)
    event.save!
    @events = Event.where(user_id: current_user.id)
  end

  def update
    event = Event.find(params[:id])
    @events = Event.where(user_id: current_user.id)
    event.update(event_params)
  end

  def destroy
    @user = User.find(params[:id])
    event = Event.find(params[:id])
    event.destroy
    redirect_to user_events_path(@user)
  end

  private

  def event_params
    params.require(:event).permit(:user_id, :title, :body, :allday, :start, :end)
  end

end
