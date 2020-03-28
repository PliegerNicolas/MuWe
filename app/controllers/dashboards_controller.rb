class DashboardsController < ApplicationController
  def dashboard
    @events_created = current_user.events.order(:status, created_at: :desc) # where.not(status: nil, address: nil)    security needed for later when seeds gone
    @events_participating = Event.where.not(user: current_user).joins(:participants).where("participants.user_id = ?", current_user.id)
    authorize @events_created
  end
end
