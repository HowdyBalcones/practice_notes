/* REFERENCE
 * exporting/importing -- https://www.codecademy.com/courses/learn-intermediate-javascript/articles/implementing-modules-using-es-6-syntax
 * canvas API -- https://developer.mozilla.org/en-US/docs/Web/API/Canvas_API/Tutorial
 * IMPORTANT NOTES
 * - if we are using modules in a script we need to run an http-server with npm for security reasons
 *   command = cd ./projectFolder; http-server
 * - if the browser doesn't seem to be updating the code, hard refresh the cache with cmd + shift + R 
 */
import { AnimatedShape, Square, Rectangle, Circle, Triangle, RegularPolygon, animateShapes, spawnShapes } from './shapeFunctions.js';
const canvasFunc = () => {
	// this references the canvas element and initializes it to a variable
	const canvas = document.getElementById("canvas");

	// this gets the rendering context of the canvas variable
	// the actual drawing will be done by referencing this variable
	const ctx = canvas.getContext("2d");
	
	// fillRect(x,y,width,height)
	const square2 = new Square(20, 20, [200, 100, 25], 0, 25);
	ctx.fillStyle = "rgb(100 100 20)";
	ctx.fillRect(100, 100, square2.side, square2.side);

	ctx.fillStyle = "rgb(200 0 0)";
	ctx.fillRect(50, 50, 20, 20);

	ctx.fillStyle = "rgb(0 200 0 / 70%)";
	ctx.fillRect(20, 20, 50, 50);
}

const shapeFunc = () => {
	const testParentShape = new AnimatedShape(10,10,[100,30,0],5);
	const circle = new Circle(25,25,50,0,10,[100,100,0],1);
	const square = new Square(50, 50, [0, 150, 25], 0, 25);
	const rectangle = new Rectangle(75, 25, 10, 20, [100, 0, 0], 0);
	const triangle = new Triangle(10, 30, [100, 255, 0], 0, 3,4,5);
	const regularPoly = new RegularPolygon(30, 30, [0, 0, 75], 0, 10, 10);
	
	console.log(`
		${testParentShape.speed}
		Circle: ${circle.color}
		${square.giveValues()}
		${rectangle.giveValues()}
		${triangle.giveValues()}
		${regularPoly.giveValues()}`);

}

//canvasFunc();
shapeFunc();
// const triangle = new Triangle(20,30,[100,255,0], 0, 10,11,12);
// console.log(triangle.points);
spawnShapes('triangle', 100);
spawnShapes('circle', 100);
spawnShapes('square', 100);
spawnShapes('rectangle', 100);
animateShapes();

//  const rectangle = new Rectangle(5,5);
//  console.log(rectangle.giveValues());


// What is to be done
// we finished the objects, attached objects to canvas methods, and finally the outline of the rendering function
// - animate the objects with basic trajectories
// - finish rendering functions for the rest of the shapes
// - build a function that takes user input on the page, IE this many shapes, this shape type, this color, and on click spawns them
// - 
