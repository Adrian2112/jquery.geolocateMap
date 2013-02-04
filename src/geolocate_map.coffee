class GeolocateMap
  constructor: ($element, settings) ->
    console.log("init")
    @map = new google.maps.Map($element[0], settings['google_maps'])

    @rand = (new Date()).getTime()
    console.log 'set markers'
    @markers = Marker.markes_from_objects(@map, settings['markers'])

    if @markers.length > 1
      @map.fitBounds(Marker.bounds_for_markers(@markers))

