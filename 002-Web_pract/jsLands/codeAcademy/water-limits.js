// this is the converters file, now the functions inside are available to the rest of this file.
const converters = require('./converters-temp.js');

// function celsiusToFahrenheit(celsius) {
// 	return celsius * (9/5) + 32;
// }
const freezingPointC = 0;
const boilingPointC = 100;

const freezingPointF = converters.celsiusToFahrenheit(freezingPointC);
const boilingPointF = converters.celsiusToFahrenheit(boilingPointC);

console.log(`The freezing point of water in Fahrenheit is ${freezingPointF}`);
console.log(`The boiling point of water in Fahrenheit is ${boilingPointF}`);
