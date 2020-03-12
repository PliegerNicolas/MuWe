class SearchController < ApplicationController
  def index
    @lng = params[:longitude]
    @lat = params[:latitude]
    @events = Event.near([@lat, @lng]) unless @lng.nil? && @lat.nil?
    # byebug
    render json: { events: @events, a: @lat, b: @lng }
  end
end
