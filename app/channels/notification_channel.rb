class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_resident
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
