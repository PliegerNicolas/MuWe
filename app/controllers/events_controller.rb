class EventsController < ApplicationController
  def index
    @events = policy_scope(Event)
  end

  def jams
    @events = policy_scope(Event)
    authorize @events
  end

  def new
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
end
