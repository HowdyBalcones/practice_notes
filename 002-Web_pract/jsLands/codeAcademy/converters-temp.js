// first syntax for export
function celsiusToFahrenheit(celsius) {
	return celsius * (9/5) + 32;
}
module.exports.celsiusToFahrenheit = celsiusToFahrenheit;

// second syntax for export
module.exports.fahrenheitToCelsius = function(fahrenheit) {
	return (fahrenheit - 32) * (5/9);
}
