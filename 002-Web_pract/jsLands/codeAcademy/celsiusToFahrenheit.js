// Using object destructuring, we pull just one function from the converters file. 
const { celsiusToFahrenheit } = require('./converters-temp.js')

// function celsiusToFahrenheit(celsius) {
// 	return celsius * (9/5) + 32;
// }

const celsiusInput = process.argv[2]; // this gets args from the cli with node :^0
const fahrenheitValue = celsiusToFahrenheit(celsiusInput); // this takes that input variable and uses it in a function 0^:

console.log(`${celsiusInput} degrees Celsius = ${fahrenheitValue} degrees Fahrenheit`);

