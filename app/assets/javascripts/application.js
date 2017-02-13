// This is a manifest file that'll be compiled into application.js, which will
// include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts,
// vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here
// using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at
// the bottom of the compiled file. JavaScript code in this file should be
// added after the last require_* statement.
//
// Read Sprockets README:
// https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap/affix
//= require bootstrap/alert
//= require bootstrap/button
//= require bootstrap/carousel
//= require bootstrap/collapse
//= require bootstrap/dropdown
//= require bootstrap/modal
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require bootstrap/scrollspy
//= require bootstrap/tab
//= require bootstrap/transition
//= require cable
//= require_tree ./channels/
//= require residents
//= require serviceworker-companion

// Register the serviceWorker script at /serviceworker.js from our server if supported
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js').then(function(reg) {
    console.log('Service worker change, registered the service worker');
  });
}
// Otherwise, no push notifications :(
else {
  console.error('Service worker is not supported in this browser');
}

navigator.serviceWorker.ready.then(function(serviceWorkerRegistration) {
  serviceWorkerRegistration.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: window.vapidPublicKey
  });
});

$(document).on('ready', function(e) {
  $('.webpush-button').on('click', function(e) {
    console.log('webpush subscribe clicked');

    navigator.serviceWorker.ready.then(function(serviceWorkerRegistration) {
      serviceWorkerRegistration.pushManager.getSubscription().then(function(subscription) {
        $.post('/subscriptions/push', {
          subscription: subscription.toJSON()
        });
      });
    });
  });
});

// Let's check if the browser supports notifications
if (!("Notification" in window)) {
  console.error("This browser does not support desktop notification");
}

// Let's check whether notification permissions have already been granted
else if (Notification.permission === "granted") {
  console.log("Permission to receive notifications has been granted");
}

// Otherwise, we need to ask the user for permission
else if (Notification.permission !== 'denied') {
  Notification.requestPermission(function (permission) {
  // If the user accepts, let's create a notification
    if (permission === "granted") {
      console.log("Permission to receive notifications has been granted");
    }
  });
}
