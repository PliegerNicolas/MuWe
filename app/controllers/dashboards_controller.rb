class DashboardsController < ApplicationController
  def dashboard
    @events_created = Event.where(user_id: current_user.id)
    @events_participating = Participant.where(user: current_user.id).map(&:event)
    authorize @events_created
  end
end
