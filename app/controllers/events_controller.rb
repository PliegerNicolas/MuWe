class EventsController < ApplicationController
  def index
    @events = policy_scope(Event).where.not(latitude: nil, longitude: nil)

    @markers = @events.map do |event|
      {
        lng: event.longitude,
        lat: event.latitude
      }
    end
  end

  def jams
    @events = policy_scope(Event)
    authorize @events
  end

  def new
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    authorize @event
    if @event.save
      @event.participants.create(user_id: @event.user_id, event_id: @event.id, status: 1)
      redirect_to event_path(@event.id)
    else
      render :new
    end
  end

  def show
    set_event
  end

  def edit
  end

  def update
  end

  def destroy
    @event = Event.find(params[:id])
    @event.finished! # this should archive and will archive
    authorize @event
    redirect_to jams_path
  end

  private

  def event_params
    params.require(:event).permit(
      :user_id, :music_style_id,
      :country, :city, :address, :longitude, :latitude,
      :title, :description,
      :max_players, :status,
      :start_date, :start_time, :duration
    )
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
