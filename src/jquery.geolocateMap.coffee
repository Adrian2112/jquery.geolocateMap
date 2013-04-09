(($) ->

  defaults =

    # google maps api options
    google_maps:
      zoom: 0 # works only when markes lenght <= 1
      center: new google.maps.LatLng(0.0, 0.0)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scaleControl: true


    # list of markers to display
    markers: [
      # {
      #   lat: 'latitude'
      #   lng: 'longitude'
      #   infoWindow: 'text' // html that want to be displayed when the marker is clicked
      #   other google api marker options
      #   (this options overrides the markers_settings just for this marker)
      #
      #   sync_inputs: {
      #     lat: '#lat'
      #     lng: '#lng'
      #     address: '#address'
      #   }
      # }
    ]

    markers_settings: {
      fit_bounds: true # set map to fit bounds of all markers

      # google maps api options for all markers
      draggable: true
    }

    locate_me: false
    locate_me_marker: {
      # icon: "https://chart.googleapis.com/chart?chst=d_map_xpin_letter&chld=pin%7C+%7C0000FF%7C000000%7CFF0000"
      # shadow: new google.maps.MarkerImage(
      #     "http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
      #     new google.maps.Size(40, 37),
      #     new google.maps.Point(0, 0),
      #     new google.maps.Point(12, 35)
      # )
      draggable: false
    }

  methods =
    init: (args) ->
      settings = $.extend true, {}, defaults, args
      this.data("geolocate_map", (new GeolocateMap(this, settings)))

    google_map: ->
      this.data("geolocate_map").map

    google_markers: ->
      $(this.data("geolocate_map").markers).map (i, marker) ->
        return marker.gmark

  $.fn.geolocateMap = (method) ->

    if methods[method]
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ))
    else if typeof method == 'object' || ! method
      return methods.init.apply( this, arguments )
    else
      $.error("Method #{method} does not exist on jQuery.geolocateMap")


)(jQuery)
