// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

if (navigator.geolocation) {
  function success(position) {
    var latitude  = position.coords.latitude;
    var longitude = position.coords.longitude;

    console.log('Latitude is ' + latitude + '°, Longitude is ' + longitude + '°');
    navigator.geolocation.clearWatch(watchID);
    $.post('/residents/geolocation', {
      resident: { latitude: latitude, longitude: longitude }
    });
  }

  function error() {
    console.log('Unable to retrieve your location');
  }

  var geo_options = {
    enableHighAccuracy: true,
    maximumAge        : 30000,
    timeout           : 27000
  };

  var watchID = navigator.geolocation.watchPosition(success, error, geo_options);
}
else {
  console.log('navigator.geolocation is not supported by the browser');
}
