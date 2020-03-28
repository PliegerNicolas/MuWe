class DashboardsController < ApplicationController
  def dashboard
    @events_created = current_user.events.where.not(status: nil, address: nil).order(:status, created_at: :desc)
    @events_participating = Event.where.not(user: current_user).joins(:participants).where("participants.user_id = ?", current_user.id)
    authorize @events_created
  end
end
