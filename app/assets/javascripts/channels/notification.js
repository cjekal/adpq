App.notification = App.cable.subscriptions.create("NotificationChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('connected to NotificationChannel');
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected from NotificationChannel');
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received from NotificationChannel');
    console.log(data);
  }
});
