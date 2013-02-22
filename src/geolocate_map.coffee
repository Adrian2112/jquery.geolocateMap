class GeolocateMap
  constructor: ($element, settings) ->
    @map = new google.maps.Map($element[0], settings['google_maps'])

    @markers = Marker.markers_from_objects(@map, settings['markers'], settings['markers_settings'])

    markers_options = settings['markers_settings']

    if markers_options['fit_bounds']
      if @markers.length >= 2
        @map.fitBounds(Marker.bounds_for_markers(@markers))
      else if @markers.length == 1
        @map.setCenter(@markers[0].get_position())

    if settings['locate_me'] and navigator.geolocation
      navigator.geolocation.getCurrentPosition(
        ((position) =>
          @marker_me = new Marker(@map,{lat: position.coords.latitude, lng: position.coords.longitude}, settings['locate_me_marker'])
          @map.setCenter(@marker_me.get_position())
        ),
        ((msg) ->
          console.log("geolocation error: #{JSON.stringify msg}")
        )
      )

