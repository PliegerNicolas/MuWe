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
    @times = ['00:00', '00:30', '01:00', '01:30', '02:00', '02:30', '03:00', '03:30', '04:00', '04:30', '05:00', '05:30', '06:00', '06:30', '07:00', '07:30', '08:00', '08:30', '09:00', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30', '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30', '16:00', '16:30', '17:00', '17:30', '18:00', '18:30', '19:00', '19:30', '20:00', '20:30', '21:00', '21:30', '22:00', '22:30', '23:00', '23:30']
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

  def nearby
    @event = Event.new
    authorize @event
    events = Event.near([params[:latitude], params[:longitude]])
    render json: { events: events }
  end

  private

  def event_params
    params.require(:event).permit(
      :user_id, :music_style_id,
      :country, :city, :address, :longitude, :latitude,
      :title, :description,
      :max_players, :status,
      :start_date, :start_time, :end_time,
      :location_photo
    )
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end
end
