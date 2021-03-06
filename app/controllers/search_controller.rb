class SearchController < ApplicationController
  def index
    @lng = params[:longitude]
    @lat = params[:latitude]
    @max_lat = params[:max_lat]
    @min_lat = params[:min_lat]
    @max_lng = params[:max_lng]
    @min_lng = params[:min_lng]

    @events = policy_scope(Event).where.not(latitude: nil, longitude: nil)
                                 .where('longitude >= :min AND longitude <= :max', min: @min_lng, max: @max_lng)
                                 .where('latitude >= :min AND latitude <= :max', min: @min_lat, max: @max_lat)

    filter_params = {
      periode: params[:periode],
      start_time: params[:start_time],
      end_time: params[:end_time],
      max_players: params[:max_players],
      status: params[:status]
    }

    unless filter_params[:periode].blank?
      periode_uniq = Date.today.strftime('%F') if filter_params[:periode] == "Today"
      periode_uniq = (Date.today - 1.day).strftime('%F') if filter_params[:periode] == "Yesterday"
      periode_uniq = (Date.today + 1.day).strftime('%F') if filter_params[:periode] == "Tomorrow"
      periode_multiple = [Date.today, Date.today + 7.day] if filter_params[:periode] == "7 days from now"
      periode_multiple = [Date.today, Date.today + 14.day] if filter_params[:periode] == "14 days from now"
      @events = @events.filter_by_periode_uniq(periode_uniq) if periode_uniq
      @events = @events.filter_by_periode_multiple(periode_multiple) if periode_multiple
    end
    unless filter_params[:start_time].blank? && filter_params[:end_time].blank?
      time = [filter_params[:start_time], filter_params[:end_time]]
      @events = @events.filter_by_time(time) if time && time[0] < time[1]
    end
    @events = @events.filter_by_max_players(filter_params[:max_players]) unless filter_params[:max_players].blank?
    if !filter_params[:status].blank? && filter_params[:status] == 'Ongoing/Planned'
      status_multiple = filter_params[:status].split('/')
      status_multiple.map!(&:downcase)
      @events = @events.filter_by_duo_status(status_multiple)
    elsif !filter_params[:status].blank?
      @events = @events.filter_by_status(filter_params[:status].downcase!)
    end

    @events.order(start_time: :desc)

    unless params[:city].blank?
      results = Geocoder.search(params[:city])
      @city_coords = results.first.coordinates
    else
      @city_coords = []
    end

    @map_box_limit = [@max_lat, @min_lat, @max_lng, @min_lng]

    if current_user
      unless current_user.profile.latitude.blank? || current_user.profile.longitude.blank?
        user_pos = [current_user.profile.latitude, current_user.profile.longitude]
      end
    end

    @posts = Profile.near([@lat, @lng], 30).joins(user: :posts).order("posts.created_at desc").limit(20).map { |profile| profile.user.posts }.flatten # Get all close posts

    posts_html = render_to_string @posts
    cards_html = render_to_string @events

    render json: {
      events: @events.as_json( include: [ :user, :music_style ] ),
      a: @lat,
      b: @lng,
      max_lat: @max_lat,
      min_lat: @min_lat,
      max_lng: @max_lng,
      min_lng: @min_lng,
      cards: cards_html,
      posts: posts_html,
      city_coords: @city_coords,
      map_box_limit: @map_box_limit
    }
  end
end
