class DashboardsController < ApplicationController
  def dashboard
    @events = Event.where(user_id: current_user.id)
    authorize @events
  end
end
