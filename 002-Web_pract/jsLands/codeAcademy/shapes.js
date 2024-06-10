// this file is for defining area of shapes

module.exports.circleArea = function (circleRadius) {
	return Math.pow(circleRadius, 2) * Math.PI;
};

module.exports.squareArea = function (sideLength) {
	return sideLength * sideLength;
};


