class Marker
    
  constructor: (map, data, settings) ->

    latitude = data['lat']
    longitude = data['lng']
     
    pos = new google.maps.LatLng(latitude, longitude)

    marker_position = {
      'position': pos
      'map': map
    }

    # replace default settings for all markers
    # with this markers 'data' settings
    settings = $.extend({}, settings, data, marker_position)

    @gmark = new google.maps.Marker(settings)
    @sync_inputs(settings)

  get_position: ->
    @gmark.getPosition()

  set_position: (latLng) ->
    @gmark.setPosition(latLng)

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

  sync_inputs: (settings) =>
    if settings['sync_inputs']
      $lat = $(settings['sync_inputs']['lat'])
      $lng = $(settings['sync_inputs']['lng'])
      $address = $(settings['sync_inputs']['address'])

      # sync map with inputs
      if $lat
        $lat.val(@.get_position().lat())
        $lat.on 'change', =>
          @.set_position(new google.maps.LatLng($lat.val(), @.get_position().lng()))

      if $lng
        $lng.val(@.get_position().lng())
        $lng.on 'change', =>
          @.set_position(new google.maps.LatLng(@.get_position().lat(), $lng.val()))

      if $address
        @set_address_to_input($address)

        $address.on 'change', =>
          geocoder = new google.maps.Geocoder()
          geocoder.geocode {address: $address.val()}, (result, status) =>
            position = result[0].geometry.location
            map = @gmark.getMap()
            map.setCenter(position)
            map.setZoom(15)
            @.set_position(position)
            google.maps.event.trigger(@gmark, 'dragend')
            

      #on marker move
      google.maps.event.addListener @gmark, 'dragend', =>
        map = @map
        position = @.get_position()

        if $lat
          $lat.val(position.lat())

        if $lng
          $lng.val(position.lng())

        if $address
          @set_address_to_input($address)

  set_address_to_input: ($address) ->
    geocoder = new google.maps.Geocoder()
    latLng = @.get_position()
    geocoder.geocode {'latLng': latLng}, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        if results[0]
          $address.val(results[0].formatted_address)
        else
          console.log("geocoder not found")
          $address.val("")
      else
        console.log("geocoder fail: #{status}")
        $address.val("")
