class Marker
    
  constructor: (map, settings) ->

    latitude = settings['lat']
    longitude = settings['lng']
    
    pos = new google.maps.LatLng(latitude, longitude)

    @gmark = new google.maps.Marker({
      'position': pos
      'map': map
      'draggable': true
    })

  get_position: ->
    @gmark.getPosition()

  @markers_from_objects: (map, markers) ->
    $(markers).map (i, e) ->
      new Marker(map, e)

  @bounds_for_markers: (markers) ->
    bounds = new google.maps.LatLngBounds()
    markers.each (i, marker) ->
      if marker instanceof Marker
        latlng = marker.gmark.getPosition()
        bounds.extend(latlng)
    
    bounds
