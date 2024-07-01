(function() {
    var doc = app.activeDocument;
    var coordinates = [];
    var iterations = 1000;
    var originPoint;
    try {
        function makeEzShape(x, y) {
            var point = doc.pathItems.ellipse(y + 2, x -2, 4, 4);
            point.filled = true;
            point.stroked = false;
            point.fillColor = new RGBColor();
            point.fillColor.red = 0;
            point.fillColor.green = 0;
            point.fillColor.blue = 0;
            return point;
        }

        function execute(batches) {
            for (var i = 0; i < batches; ++i) {
                makeManyPoints();
                $.sleep(1000)
                originPoint = makeEzShape(coordinates[0][0], coordinates[0][1]);
                duplicatePoints(originPoint, coordinates)
                $.sleep(2000)
            }
            alert("Done", undefined, false);
        }

        function duplicatePoints(original, array) {
            // suspend redrawing -- crucial, need to understand more;
            app.executeMenuCommand('selectall');
            app.executeMenuCommand('deselectall');
            app.redraw();

            for (var i = 0; i < array.length; ++i ) {
                var x = array[i][0];
                var y = array[i][1];
                var newPoint = original.duplicate();
                newPoint.position = [x,y];
            }
            app.redraw();
        };

        function makeManyPoints() {
            for (var i = 0; i < iterations; ++i) {
                coordinates.push([Math.random() * doc.width, Math.random() * -doc.height]);
            }
        }
    execute(10);
        // alert(coordinates.join("\n"));
    } catch(e) {
        alert("Something in main" + e)
    }


})();