<html>

<head>
<%@ page import="org.json.simple.*"%>
<% 

String json_output = "[]";
try {
	json_output = request.getParameter("value"); 

}
catch (Exception ex){
}
%>

<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<title>Indix Hackathon</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style>
			body, html {
				margin:0;
				padding:0;
				font-family:Arial;
			}
			h1 {
				margin-bottom:10px;
			}
			#main {
				position:relative;
				width:1020px;
				padding:20px;
				margin:auto;
			}
			#heatmapArea {
				position:relative;
				float:left;
				width:800px;
				height:600px;
				border:1px dashed black;
			}
			#configArea {
				position:relative;
				float:left;
				width:200px;
				padding:15px;
				padding-top:0;
				padding-right:0;
			}
			.btn {
				margin-top:25px;
				padding:10px 20px 10px 20px;
				-moz-border-radius:15px;
				-o-border-radius:15px;
				-webkit-border-radius:15px;
				border-radius:15px;
				border:2px solid black;
				cursor:pointer;
				color:white;
				background-color:black;
			}
			#gen:hover{
				background-color:grey;
				color:black;
			}
			textarea{
				width:260px;
				padding:10px;
				height:200px;
			}
			h2{
				margin-top:0;
			}

			#technology_select{
				margin-top: 20%;
			}
		</style>
<link rel="shortcut icon" type="image/png" href="http://www.patrick-wied.at/img/favicon.png" />
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>

</head>
<body>
<div id="main">
	<div id="heatmapArea"></div>
	<div id="configArea">
		<div id="tog" class="btn">Toggle HeatmapOverlay</div>
		<form action="view_technology" id="technology_select" method="get">
			<input type="radio" name="technology_select" value="anime">Animation<br/>
			<input type="radio" name="technology_select" value="android">Android<br/>
			<input type="radio" name="technology_select" value="apple">Apple<br/>
			<input type="radio" name="technology_select" value="biology">Biology<br/>
			<input type="radio" name="technology_select" value="chemistry">Chemistry<br/>
			<input type="radio" name="technology_select" value="crypto">Crypto<br/>
			<input type="radio" name="technology_select" value="cs">Computer Science<br/>
			<input type="radio" name="technology_select" value="drupal">Drupal<br/>
			<input type="radio" name="technology_select" value="dsp">Digital Signal Processing<br/>
			<input type="radio" name="technology_select" value="electronics">Electronics B-)<br/>
			<input type="radio" name="technology_select" value="gamedev">Game Development<br/>
			<input type="radio" name="technology_select" value="magento">Magento<br/>
			<input type="radio" name="technology_select" value="math">Maths<br/>
			<input type="radio" name="technology_select" value="networkengineering">Networking<br/>
			<input type="radio" name="technology_select" value="salesforce">Sales Force<br/>
			<input type="radio" name="technology_select" value="ubuntu">Ubuntu<br/>
			<input type="submit" value="submit"/>
	</div>
</div>
<script type="text/javascript" src="js/heatmap.js"></script>
<script type="text/javascript" src="js/heatmap-gmaps.js"></script>
<script type="text/javascript">

var map;
var heatmap; 

window.onload = function(){

	var myLatlng = new google.maps.LatLng(48.3333, 16.35);
	var myOptions = {
	  zoom: 2,
	  center: myLatlng,
	  mapTypeId: google.maps.MapTypeId.ROADMAP,
	  disableDefaultUI: false,
	  scrollwheel: true,
	  draggable: true,
	  navigationControl: true,
	  mapTypeControl: false,
	  scaleControl: true,
	  disableDoubleClickZoom: false
	};
	map = new google.maps.Map(document.getElementById("heatmapArea"), myOptions);
	
	heatmap = new HeatmapOverlay(map, {"radius":20, "visible":true, "opacity":0});
	
	
	document.getElementById("tog").onclick = function(){
		heatmap.toggle();
	};
	
	var testData={
    		max: 46,
    		data: <%= json_output %>
    		//[{lat: 25.72, lng:-80.2707, count: 200},{lat: 34.5873, lng:-118.245, count: 200},{lat: 35.8278, lng:-78.6421, count: 200}]
    	};
    	// this is important, because if you set the data set too early, the latlng/pixel projection doesn't work
	google.maps.event.addListenerOnce(map, "idle", function(){
		heatmap.setDataSet(testData);
	});
};

</script>
</body>
</html>
