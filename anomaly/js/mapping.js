var topographic = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Shaded_Relief/MapServer/tile/{z}/{y}/{x}', {
  maxZoom: 15,
  minZoom: 7,
  attribution: 'Tiles &copy; Esri &mdash; Source: Esri'
}),
streets = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}', {
  maxZoom: 15,
  minZoom: 7,
  attribution: 'Tiles &copy; Esri &mdash; Source: Esri, DeLorme, NAVTEQ, USGS, Intermap, iPC, NRCAN, Esri Japan, METI, Esri China (Hong Kong), Esri (Thailand), TomTom, 2012'
});

var stop_sites = L.layerGroup();
var counties_layer = L.layerGroup();
var other_features = L.layerGroup();

var blackIcon = L.icon({
iconUrl: 'img/map-marker.svg',
iconSize: [11,44],
iconAnchor: [11,44],
popupAnchor: [0,-10]
});

var redIcon = L.icon({
iconUrl: 'img/map-marker-red.svg',
iconSize: [11,44],
iconAnchor: [11,44],
popupAnchor: [0,-10]
});

var iceIcon = L.icon({
iconUrl: 'img/ice.png',
iconSize: [20,25],
iconAnchor: [10,10],
popupAnchor: [0,-5]
});

//var Sites = L.layerGroup([stops]);


function wi_counties_style(feature) {
return {
    fillColor: '#BDBDBD',
    weight: 1,
    opacity: 1,
    color: '#FFF',
    dashArray: '',
    fillOpacity: 0.3
};
}


var popup1 = L.popup({
  maxWidth : 1800
});
var popup2 =
{
  'maxWidth': '500',
  'className' : 'another-popup' // classname for another popup
}


var grid = new L.GeoJSON.AJAX("data/grid.geojson", {
  style : function(feature) {
    return {
      color: '#C07A7A',
      weight: 0,
      fillColor: '#C07A7A'
    }
  }
}).addTo(other_features);

var wi_counties = new L.GeoJSON.AJAX("data/wi_counties.geojson", {
  style: wi_counties_style,
  onEachFeature: function (feature, layer) {
    layer.on('mouseover', function () {
        this.setStyle({
          weight: 1,
          color: '#666',
          dashArray: '',
          fillOpacity: 0.8
        });
    });
    layer.on('mouseout', function () {
        wi_counties.resetStyle(this);
    },layer.bindPopup('<p> '+feature.properties.county_nam+' County</p>')
    );
}
}).addTo(counties_layer);


var continent = new L.GeoJSON.AJAX("data/continent.geojson", {
  style : function(feature) {
    return {
      color: '#000',
      weight: 0.35
    }
  }
}).addTo(other_features);

var wisc_glacier = new L.GeoJSON.AJAX("data/wisc_glacier.geojson", {
  style : function(feature) {
    return {
      color: '#000',
      weight: 0.35
    }
  }
}).addTo(other_features);

var stops = new L.GeoJSON.AJAX("data/stops.geojson",{
  style : function(feature) {
    return {
      color: '#000',
      weight: 0.5
    }
  },
  pointToLayer: function(geoJsonPoint, latlng) {
    return L.marker(latlng,{
    icon: iceIcon
  });
  },
  onEachFeature: function(feature, layer) {
    layer.on('click',function(e) {
      map.setView(e.latlng,11);
    }),
    layer.bindPopup('<h2> Site: '+feature.properties.Name+'</h2><p><img src=" '
      +feature.properties.Image+'" alt=""></p><p> '
      +feature.properties.ImageCap1+'</h2><p><img src=" '
        +feature.properties.Image2+'" alt=""></p><p> '
      +feature.properties.ImageCap2+'</p><p>'
        +feature.properties.Description+'</p>', popup2);
  }
}).addTo(stop_sites);


var map = L.map('mapid', {
  center: [43.8,-88],
  zoom: 10,
  layers: [topographic, stop_sites, other_features]
});
//.setView([43.8,-88],10);

var baseLayers = {
"Topographic":topographic,
"Streets": streets
};

var overlays = {
"StopSites": stop_sites,
"Counties": counties_layer,
"Darker": other_features
};

L.control.layers(baseLayers, overlays).addTo(map);
