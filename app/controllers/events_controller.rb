class EventsController < ApplicationController
  before_action :set_event, only: [:show, :notify]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def notify
    NotificationChannel.broadcast_to(Resident.find(session[:resident_id]), event: @event)
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event has been notified.' }
      format.json { render :show, status: :notified, location: @event }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
