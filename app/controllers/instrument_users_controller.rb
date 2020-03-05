class InstrumentUsersController < ApplicationController
  def accept
    @participant = Participant.find(params[:id])
    @participant.accepted!
    authorize @participant
    @participant.save
    redirect_to event_participants_path(params[:event_id])
  end

  def decline
    @participant = Participant.find(params[:id])
    @participant.declined!
    authorize @participant
    @participant.save
    redirect_to event_participants_path(params[:event_id])
  end
end
