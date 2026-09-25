var app = index.app

function send(data) {
  app.ports.geolocationSub.send(data);
}

// Reverse geocoding (coordinates -> place name) with a Nominatim-compatible API.
// Mapzen, used originally, shut down in 2018. See the Nominatim usage policy before
// pointing a public server at nominatim.openstreetmap.org.
var geocoderUrl = process.env.HEBORN_GEOCODER_URL;

app.ports.geolocationCmd.subscribe(function(cmd) {
  switch (cmd.msg) {
    case 'coordinates':
      var watchID = null;

      watchID = navigator.geolocation.watchPosition(
        function(pos){
        send({
          'msg': 'coordinates',
          'id': cmd.id,
          'lat': pos.coords.latitude,
          'lng': pos.coords.longitude
        });
          navigator.geolocation.clearWatch(watchID);
        },
        null,
        {enableHighAccuracy:true}
      );

      break;
    case 'label':
      var lat = cmd.lat, lng = cmd.lng;
      var conn = new XMLHttpRequest();
      var url = geocoderUrl + '?format=jsonv2&lat=' + encodeURIComponent(lat) + '&lon=' + encodeURIComponent(lng);

      conn.onreadystatechange = function() {
        if (conn.readyState == 4 && conn.status == 200) {
          var resp = JSON.parse(conn.responseText);

          if (resp && resp['display_name']) {
            send({
              'msg': 'label',
              'id': cmd.id,
              'label': resp['display_name']
            });
          }

        }
      }

      conn.open('GET', url, true);
      conn.send();

      break;
    default:
      console.log(
        'Geolocation communication error: command "'
        + cmd.msg
        + '" does not exist.'
      );
  }
});
