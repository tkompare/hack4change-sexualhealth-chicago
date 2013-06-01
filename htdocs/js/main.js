
// Is the user's device touch capable?
var touch = Modernizr.touch;

// If touch, let them touch the map.
if(touch)
{
	TheMap.setTouchScroll(true);
}

// Make a button on the map that can turn on and off touch pan/zoom
function panZoomControl(controlDiv)
{
	// Set CSS styles for the DIV containing the control
	// Setting padding to 5 px will offset the control
	// from the edge of the map.
	controlDiv.style.padding = '1em';
	// Set CSS for the control border.
	var controlUI = document.createElement('div');
	controlUI.style.backgroundColor = '#015289';
	controlUI.style.color = 'white';
	controlUI.style.borderStyle = 'solid';
	controlUI.style.borderWidth = '0px';
	controlUI.style.cursor = 'pointer';
	controlUI.style.textAlign = 'center';
	controlUI.style.borderRadius = '6px';
	controlUI.title = 'Click to interact with the map.';
	controlDiv.appendChild(controlUI);
	// Set CSS for the control interior.
	var controlText = document.createElement('div');
	controlText.style.fontFamily = 'sans-serif';
	controlText.style.fontSize = '12px';
	controlText.style.paddingLeft = '.5em';
	controlText.style.paddingRight = '.5em';
	controlText.style.paddingTop = '.3em';
	controlText.style.paddingBottom = '.3em';
	controlText.innerHTML = 'Explore Map';
	controlUI.appendChild(controlText);
	
	google.maps.event.addDomListener(controlUI, 'click', function() {
		var cntr = TheMap.Map.getCenter();
		if(TheMap.Map.zoomControl === false)
		{
			TheMap.setPanZoom(true);
			if(touch)
			{
				TheMap.setTouchScroll(false);
			}
			$('#map-title').hide(0,function(){
				$('#map-width').css('height','100%');
				$('#map-ratio').css('margin-top', $(window).height());
				controlUI.title = 'Click to close up the map.';
				controlText.innerHTML = 'Minimize';
				TheMap.Map.setCenter(cntr);
				google.maps.event.trigger(TheMap.Map, 'resize');
			});
		}
		else
		{
			TheMap.setPanZoom(false);
			if(touch)
			{
				TheMap.setTouchScroll(true);
			}
			$('#map-title').show(0,function(){
				$('#map-width').css('height','');
				$('#map-ratio').css('margin-top','200px');
				controlUI.title = 'Click to interact with the map.';
				controlText.innerHTML = 'Explore Map';
				TheMap.Map.setCenter(cntr);
				google.maps.event.trigger(TheMap.Map, 'resize');
			});
		}
	});
}

var PanZoomControlDiv = document.createElement('div');
panZoomControl(PanZoomControlDiv);
PanZoomControlDiv.index = 1;
TheMap.Map.controls[google.maps.ControlPosition.TOP_RIGHT].push(PanZoomControlDiv);
