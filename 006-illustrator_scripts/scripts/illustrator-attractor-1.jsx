// goal is to simulate a basic attractor inside illustrator 

(function() {
	
	var doc = app.activeDocument;
	var artboard = doc.artboards[0];
	var selectedItems = doc.selection;

	try {
	// need to plot random points on the artboard, also need a random int generator, rest should be according 
	// to the specifics of each algorithm 
		
		function getRandomInt(min, max) {
			min = Math.ceil(min);
			max = Math.floor(max);
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		function getRandomFloat(min, max) {
			return Math.random() * (max - min + 1) + min;
		}

		function repositionItem(selectedItem, artboard) {
       			 var abBounds = artboard.artboardRect;
       			 var left = abBounds[0];
       			 var top = abBounds[1];
       			 var right = abBounds[2];
       			 var bottom = abBounds[3];

       			 var newPositionX = getRandomInt(left, right - selectedItem.width);
       			 var newPositionY = getRandomInt(bottom + selectedItem.height, top);
       			 selectedItem.position = [newPositionX, newPositionY];
		}



	} catch(e) {
		alert("Position: random int or reposition item " + e)
	}

	try {

		function cliffordAttractor() {
			var a,b,c,d,xn,yn;
			var initialX,initialY, initialPoint;
			var abBounds = artboard.artboardRect;
			var plot = [];

			// number of times the selected item is iterated
			var iterations = 100000;
			
			// parameters for the transformation
			a = getRandomFloat(-2, 3);
			b = getRandomFloat(-1, 2);
			c = getRandomFloat(1, 4);
			d = getRandomFloat(-2, 3);

			// eventually want to be able to pass in an object that gets centered on the artboard
			initialX = abBounds[2] / 2;
			initialY = abBounds[3] / -2;
			initialPoint = [initialX, initialY];
				
			var originObj = selectedItems[0];
			xn = originObj.left;
			yn = originObj.top;		


			// this is how to duplicate a PathItem
		//	var originalItem = selectedItems[0].duplicate()
		//	originalItem.left += 100;
		//	originalItem.top -= 100;
			function generatePlot() {
			for (var i = 0; i < 5000; ++i) {
				xn = Math.sin(a * (yn + i)) + c * Math.cos(a * (xn + i));
				yn = Math.sin(b * (xn + i)) + d * Math.cos(b * (yn + i));
				plot.push([xn,yn]);
				}
			}
			function copySelected(array) {
				for (var i = 0; i < array.length; ++i) {
					var coordinates = array[i];
					var copyObj = originObj.duplicate();
					copyObj.left = coordinates[0];
					copyObj.top = coordinates[1];
				}
			}
			generatePlot();
			// alert(plot.join(" -- "))
			copySelected(plot);
		//	alert(plot.join(", "));
			// alert(selectedItems[0].left + " " + selectedItems[0].top);
			// alert(a + " " + b + " " + c + " " + d);
		//	alert(abBounds.join(", "))
		//	alert(initialX + " " + initialY);
		
		}	
		cliffordAttractor();
	} catch(e) {
		alert("Position: attractors" + e);
	} 
})();
