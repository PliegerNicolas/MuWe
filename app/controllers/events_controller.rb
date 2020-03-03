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
    @event.user_id = current_user.id
    #@event.address = address
    authorize @event
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(
      :user_id, :city,
      :address, :longitude, :latitude,
      :description, :music_style,
      :number_of_max_players,
      :date, :status
    )
  end

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def address
    [street, city, state, country].compact.join(', ')
    @event.city = city
  end
end
