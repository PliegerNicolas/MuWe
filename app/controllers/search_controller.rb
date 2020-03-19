class SearchController < ApplicationController
  def index
    @lng = params[:longitude]
    @lat = params[:latitude]
    @max_lat = params[:max_lat]
    @min_lat = params[:min_lat]
    @max_lng = params[:max_lng]
    @min_lng = params[:min_lng]

    # keep this line as reference for improvments, cause if there's no events between the boundaries of the map
    # we should still display something ??
    # @events = Event.where.not(latitude: nil, longitude: nil).near([@lat, @lng], 80) unless @lng.nil? && @lat.nil?

    @events = Event.where.not(latitude: nil).or(Event.where.not(longitude: nil))
                    .where('longitude >= :min AND longitude <= :max', min: @min_lng, max: @max_lng)
                    .where('latitude >= :min AND latitude <= :max', min: @min_lat, max: @max_lat)
                    #.where('start_date >= ? AND end_time > ?', Date.today, Time.now)

    html = render_to_string @events

    render json: {
      events: @events,
      a: @lat,
      b: @lng,
      max_lat: @max_lat,
      min_lat: @min_lat,
      max_lng: @max_lng,
      min_lng: @min_lng,
      cards: html
    }
  end
end
