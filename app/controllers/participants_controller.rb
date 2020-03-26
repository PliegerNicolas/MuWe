class ParticipantsController < ApplicationController
  def show
    set_event
    participants = @event.participants
    @postulating_participants = participants.where(status: 'postulating')
    @accepted_participants = participants.where(status: 'accepted')
    @declined_participants = participants.where(status: 'declined')
  end

  def create
    set_event
    @participant = Participant.new(user_id: current_user.id, event_id: params[:event_id])
    authorize @participant
    if Participant.where(user_id: current_user, event_id: @event.id).empty?
      @participant.save if @participant.valid?
    end
    redirect_to event_path(params[:event_id])
  end

  def destroy
    skip_authorization # Is this okay ?
    current_event = Event.find(params[:event_id])
    user_events = current_user.event_participations
    if user_events.include?(current_event)
      participants = Participant.where(user_id: current_user, event_id: current_event)
      participants.destroy_all unless participants.first.status == 'declined'
    end
    redirect_to event_path(current_event.id)
  end

  def accept
    @participant = Participant.find(params[:id])
    @participant.accepted!
    authorize @participant
    @participant.save
    redirect_to dashboard_path
  end

  def decline
    @participant = Participant.find(params[:id])
    @participant.declined!
    authorize @participant
    @participant.save
    redirect_to dashboard_path
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
    authorize @event
  end
end
