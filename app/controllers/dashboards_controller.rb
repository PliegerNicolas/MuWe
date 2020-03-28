class DashboardsController < ApplicationController
  def dashboard
    @events_created = current_user.events.order(created_at: :desc)
    @events_participating = Event.where.not(user: current_user).joins(:participants).where("participants.user_id = ?", current_user.id).order(start_date: :desc)
    authorize @events_created
  end
end
