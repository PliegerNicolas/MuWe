class EventsController < ApplicationController
  include Pagy::Backend

  def index
    # @events = policy_scope(Event).where.not(latitude: nil, longitude: nil) # For testing purpose
    @events = policy_scope(Event).where('start_date = ? and end_time > ?', Date.today, Time.now).where.not(latitude: nil, longitude: nil)

    if params[:time_filter] # Time filter
      @events = @events.where("events.start_time >= ? and events.end_time <= ?",
                              params[:time_filter][:start_time], params[:time_filter][:end_time])
    end
    @events = @events.where("events.city iLike ?", params[:city_filter][:city]) if params[:city_filter] # City filter
    @events = @events.where(status: params[:status_filter][:status].downcase) if params[:status_filter] # Status filter
  end

  def jams
    @pagy, @events = pagy(policy_scope(Event.where.not(status: 'finished')), items: 12)
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
