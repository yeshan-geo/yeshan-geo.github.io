$(document).ready(function() {

	var cities;
	var map = L.map(‘map’, {
		center: [37.8, -96],
		zoom: 4,
		minZoom: 4
	});

  L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Terrain_Base/MapServer/tile/{z}/{y}/{x}', {
    attribution: 'Tiles &copy; Esri &mdash; Source: USGS, Esri, TANA, DeLorme, and NPS',
    maxZoom: 13
  }).addTo(map);

});
