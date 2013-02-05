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
      #   other google api marker options
      #   (this options overrides the markers_settings just for this marker)
      # }
    ]

    markers_settings: {
      fit_bounds: true # set map to fit bounds of all markers

      # google maps api options for all markers
      draggable: true
    }

  methods =
    init: (args) ->
      settings = $.extend true, {}, defaults, args
      this.data("geolocate_map", (new GeolocateMap(this, settings)))
  $.fn.geolocateMap = (method) ->

    if methods[method]
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ))
    else if typeof method == 'object' || ! method
      return methods.init.apply( this, arguments )
    else
      $.error("Method #{method} does not exist on jQuery.geolocateMap")


)(jQuery)
