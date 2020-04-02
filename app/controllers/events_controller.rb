class EventsController < ApplicationController
  include Pagy::Backend

  def index
    @events = policy_scope(Event).where.not(latitude: nil, longitude: nil)
                                 .where('longitude >= :min AND longitude <= :max', min: @min_lng, max: @max_lng)
                                 .where('latitude >= :min AND latitude <= :max', min: @min_lat, max: @max_lat)

    if current_user && current_user.profile.latitude && current_user.profile.longitude
      unless current_user.profile.latitude.blank? || current_user.profile.longitude.blank?
        user_pos = [current_user.profile.latitude, current_user.profile.longitude]
        @city = Geocoder.search(user_pos).first.city
        @user_count = Profile.near(user_pos, 30).joins(:user).where(["last_user_activity >= ?", DateTime.now - 5.minutes]).to_a.count
      end
    end

    return unless user_pos # get posts

    @posts = Profile.near(user_pos, 30).joins(user: :posts).order("posts.created_at desc").limit(20).map { |profile| profile.user.posts }.flatten
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
