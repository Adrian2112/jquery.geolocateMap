class Marker
    
  constructor: (map, data, settings) ->

    latitude = data['lat']
    longitude = data['lng']
    
    pos = new google.maps.LatLng(latitude, longitude)

    marker_position = {
      'position': pos
      'map': map
    }

    settings = $.extend({}, settings, marker_position)

    @gmark = new google.maps.Marker(settings)

  get_position: ->
    @gmark.getPosition()

  @markers_from_objects: (map, markers, settings) ->
    $(markers).map (i, e) ->
      new Marker(map, e, settings)

  @bounds_for_markers: (markers) ->
    bounds = new google.maps.LatLngBounds()
    markers.each (i, marker) ->
      if marker instanceof Marker
        latlng = marker.gmark.getPosition()
        bounds.extend(latlng)
    
    bounds
