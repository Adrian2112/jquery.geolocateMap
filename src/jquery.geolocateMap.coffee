(($) ->

  defaults =

    # defaults for google maps api
    google_maps:
      zoom: 0
      center: new google.maps.LatLng(0.0, 0.0)
      mapTypeId: google.maps.MapTypeId.ROADMAP
      scaleControl: true


    # list of markers to display
    markers: [
      # {
      #   lat: 'latitude'
      #   lng: 'longitude'
      # }
    ]

  methods =
    init: (args) ->
      settings = $.extend {}, defaults, args
      this.data("geolocate_map", (new GeolocateMap(this, settings)))
  $.fn.geolocateMap = (method) ->

    if methods[method]
      return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ))
    else if typeof method == 'object' || ! method
      return methods.init.apply( this, arguments )
    else
      $.error("Method #{method} does not exist on jQuery.geolocateMap")


)(jQuery)
