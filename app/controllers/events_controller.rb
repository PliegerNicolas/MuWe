class EventsController < ApplicationController
  include Pagy::Backend

  def index
    @events = policy_scope(Event).where.not(latitude: nil, longitude: nil)
                                 .where('longitude >= :min AND longitude <= :max', min: @min_lng, max: @max_lng)
                                 .where('latitude >= :min AND latitude <= :max', min: @min_lat, max: @max_lat)
    if Geocoder.search([current_user.profile.latitude, current_user.profile.longitude]).first
      @city = Geocoder.search([current_user.profile.latitude, current_user.profile.longitude]).first.village
    else
      @city = "City not found"
    end
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
    redirect_to dashboard_path
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
    events = Event.near([params[:latitude], params[:longitude]])
  end
end
