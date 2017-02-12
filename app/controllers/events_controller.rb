class EventsController < ApplicationController
  before_action :set_event, only: [:show, :ws_notify, :wp_notify]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def ws_notify
    NotificationChannel.broadcast_to(Resident.find(session[:resident_id]), event: @event)
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event has been WebSockets notified.' }
      format.json { render :show, status: :ws_notified, location: @event }
    end
  end

  def wp_notify
    # hacks! gotta get these values and store them!
    @resident = Resident.first
    def @resident.subscription_endpoint
      ''
    end
    def @resident.subscription_keys_p256dh
      ''
    end
    def @resident.subscription_keys_auth
      ''
    end
    # end hack
    Webpush.payload_send(
      message: "Category: #{@event.category}, Zip: #{@event.zip_code}, URL: #{@event.additional_info_url}",
      endpoint: @resident.subscription_endpoint,
      p256dh: @resident.subscription_keys_p256dh,
      auth: @resident.subscription_keys_auth,
      ttl: 24 * 60 * 60,
      vapid: {
        subject: @event.category,
        public_key: ENV['VAPID_PUBLIC_KEY'],
        private_key: ENV['VAPID_PRIVATE_KEY']
      }
    )
    respond_to do |format|
      format.html { redirect_to @event, notice: 'Event has been Web Push notified.' }
      format.json { render :show, status: :wp_notified, location: @event }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
