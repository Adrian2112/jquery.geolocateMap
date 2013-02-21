# jquery.geolocateMap
Makes it easy to create a google map with many markers

[Demo](http://adrian2112.github.com/jquery.geolocateMap/demo/demo.html)

## Usage

**google maps javascript should be loaded before jquery.geolocateMap**

```html

<script src="https://maps.googleapis.com/maps/api/js?sensor=false" type="text/javascript"></script>
<script src="PATH_TO_SRC/jquery.geolocateMap.js" type="text/javascript"></script>

<script>
 $("#map").geolocateMap({
      markers: 
        [ 
          {
            "lat":"17.060477065746248", "lng":"-96.72543525695801",
            icon: pinImage,
            shadow: pinShadow,
            draggable: true
          },
          {"lat":"17.07714402", "lng":"-96.71353313"},
          {"lat":"17.068128422248872", "lng":"-96.7195987701416"},
          {"lat":"17.065593", "lng":"-96.724253"}
      ],
      google_maps: {
        zoom: 20
      },
      markers_settings: {
        draggable: false,
        animation: google.maps.Animation.DROP
      }
    })

</script>
```

## settings

```javascript
defaults = {
  // google maps api options
  google_maps: {
    zoom: 0, // works only when markes lenght <= 1
    center: new google.maps.LatLng(0.0, 0.0),
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scaleControl: true
  },

  // list of markers to display
  markers: [
    // {
    //   lat: 'latitude'
    //   lng: 'longitude'
    //   other google api marker options
    //   (this options overrides the markers_settings just for this marker)
    //   
    //   sync_inputs: {
    //     lat: '#lat' // input id
    //     lng: '#lng' 
    //     address: '#address'
    //   }
    // }
  ],

  markers_settings: {
   fit_bounds: true, // set map to fit bounds of all markers

   // google maps api options for all markers
   draggable: true
  },

  locate_me: false,
  locate_me_marker: {
    // google api marker settings
    //
    // icon: "https://chart.googleapis.com/chart?chst=d_map_xpin_letter&chld=pin%7C+%7C0000FF%7C000000%7CFF0000"
    // shadow: new google.maps.MarkerImage(
    //     "http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
    //     new google.maps.Size(40, 37),
    //     new google.maps.Point(0, 0),
    //     new google.maps.Point(12, 35)
    // )
    // sync_inputs: {} // same as markers
    //
    draggable: false
  }
}

```


# Development
Compile with
```shellscript
coffee --watch -cj jquery.geolocateMap.js src/*.coffee
```

