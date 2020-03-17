class SearchController < ApplicationController
  def index
    @lng = params[:longitude]
    @lat = params[:latitude]
    @events = Event.where('start_date = ? and end_time > ?', Date.today, Time.now)
    @events = @events.where.not(latitude: nil, longitude: nil).near([@lat, @lng], 80) unless @lng.nil? && @lat.nil?
    render json: { events: @events, a: @lat, b: @lng }
  end
end
