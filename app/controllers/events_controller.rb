class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :update, :destroy, :subscribe, :unsubscribe, :show]
  before_action :authenticate_user!, except: [:subscribe, :unsubscribe]
  respond_to :html

  def index
    @events = current_user.events.all
    respond_with(@events)
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def show
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to events_path
  end

  def update
    @event.update(event_params)
    redirect_to events_path
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  def subscribe
    # todo: refactor hide login
    @hide_login = true
  end

  def unsubscribe
    # todo: refactor hide login
    @hide_login = true
  end

  private
    def set_event
      @event = Event.find(Integer(params[:id]))
    end

    def event_params
      params.require(:event).permit(:name, :description, :user_id, :start, :duration)
    end
end
