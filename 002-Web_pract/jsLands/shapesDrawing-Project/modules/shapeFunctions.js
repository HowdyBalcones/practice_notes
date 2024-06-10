class AnimatedShape {
	constructor(x, y, [red,green,blue], xSpeed, ySpeed) {
		this._x = x;
		this._y = y;
		this.color = [red,green,blue];
		this._xSpeed = xSpeed;
		this._ySpeed = ySpeed;
	}
	set position([x, y]) {
		this._x = x;
		this._y = y;
	}
	set color([red, green, blue]) {
		// parameters < 255, represent RGB color values
		if (red < 0 || red > 255) {
			throw new Error('Red value is invalid.')
		} else if (green < 0 || green > 255) {
			throw new Error('Green value is invalid.')
		} else if (blue < 0 || blue > 255) {
			throw new Error('Blue value is invalid.')
		} else {
			this.red = red;
			this.green = green;
			this.blue = blue;
		}
	}
	set xSpeed(value) {
		this._xSpeed = value;
	}
	set ySpeed(value) {
		this._ySpeed = value;
	}
	get xSpeed() {
		return this._xSpeed;
	}
	get ySpeed() {
		return this._ySpeed;
	}
	get position() {
		return [this._x, this._y];
	}
	get color() {
		return [this.red, this.green, this.blue];
	}
	get speed() {
		return this._speed;
	}

	changePosition() {
		this._x += this._xSpeed;
		this._y += this._ySpeed;
		
	}
	checkBounding(canvas) {
		if (this._x >= canvas.width || this._x <= 0) {
			this._xSpeed *= -1;
		} else if (this._y >= canvas.height || this._y <= 0)
			this._ySpeed *= -1;
	}
}
class Circle extends AnimatedShape {
	constructor(x, y, r, sa, ea, [red,green,blue], xSpeed, ySpeed) {
		super(x, y, [red,green,blue], xSpeed, ySpeed)
		this.radius = r;
		this.startAngle = sa;
		this.endAngle = ea;
	}
	set radius(value) {
		if (value < 0) {
		throw new Error('Radius cannot be less than zero.');
		} 
		this._radius = value;
	}
	set startAngle(value) {
		this._startAngle = value;
	}
	set endAngle(value) {
		this._endAngle = value;
	}
	get area() {
		return Math.PI * Math.pow(this.radius, 2);
	}
	get circumference() {
		return 2 * Math.PI * this.radius;
	}
	get diameter() {
		return this.radius * 2;
	}
	
	get radius() {
		return this._radius;
	}	
	get startAngle() {
		return this._startAngle;
	}
	get endAngle() {
		return this._endAngle;
	}
	giveValues() {
		return `Circle -- Area: ${this.area} Radius: ${this.radius} Diameter: ${this.diameter} Circumference: ${this.circumference}`;
	}
}

class Square extends AnimatedShape {
	constructor(x, y, [red, green, blue], xSpeed, ySpeed, side) {
	super(x, y, [red,green,blue], xSpeed, ySpeed)
	this._side = side;
	}
	get perimeter() {
		return this.side*4;
	}
	get area() {
		return Math.pow(this.side, 2);
	}
	get diagonal() {
		return this.side*Math.sqrt(2);
	}
	set side(value) {
		this._side = value;
	}
	get side() {
		return this._side;
	}
	giveValues() {
		return `Square -- Area: ${this.area} Side: ${this.side} Perimeter: ${this.perimeter} Diagonal: ${this.diagonal}`
	}
	
}

class Grid extends Square {
	constructor(x, y, [red, green, blue], side, rows, columns) {
		super(x, y, [red, green, blue], side)
		this._rows = rows;
		this._columns = columns;
	}
	get totalCells() {
		return 
	}
	get square() {
		return new Square(this._x, this._y, ...this._color, 0, 0, this._side)
	}

	drawGrid() {
		let grid = [];
		for (let i = 0; i < this._rows; ++i) {
			let row = [];
			for (let j = 0; j < this._columns; ++j) {
				row.push()
			}
		}
	}
	
}

class Rectangle extends AnimatedShape {
	constructor(x, y, l, w, [red,green,blue], xSpeed, ySpeed) {
		super(x, y, [red, green, blue], xSpeed, ySpeed)
		this.length = l;
		this.width = w;
	}
	set length(value) {
		if (value < 0) {
			throw new Error('Length cannot be less than 0')
		}
		this._length = value;
	}
	set width(value) {
		if (value < 0) {
			throw new Error('Width cannot be less than 0')
		}
		this._width = value;
	}
	get length() {
		return this._length;
	}
	get width() {
		return this._width;
	}
	get perimeter() {
		return 2*(this.length + this.width);
	}
	get area() {
		return this.length * this.width;
	}
	get diagonal() {
	//	return Math.sqrt(Math.pow(this.length, 2) + Math.pow(this.width, 2));
		return Math.sqrt((this.length**2) + (this.width**2));
	}

	giveValues() {
		return `Rectangle -- Area: ${this.area} -- Length: ${this.length} -- Width: ${this.width} -- Perimeter: ${this.perimeter} -- Diagonal: ${this.diagonal}`
	}
}

class Triangle extends AnimatedShape {
	constructor(x, y, [red, green, blue],  xSpeed, ySpeed, a, b = null, c = null) {
		super(x, y, [red, green, blue], xSpeed, ySpeed);
		if (b === null && c === null) {
			this.a = a;
			this.b = a;
			this.c = a;
		} else if (c === null) {
			this.a = this.b = a;
			this.c = b;
		} else {
			this.a = a;
			this.b = b;
			this.c = c;
		}
		if (!this.isValid()) {
			throw new Error('Invalid triangle side lengths');
		}
		this._points = this.calculatePoints();
	}
	isValid() {
		// checking triangle inequality
		return (this.a + this.b > this.c &&
			this.a + this.c > this.b &&
			this.b + this.c > this.a);
	}
	isRightTriangle() {

		const sides = [this.a, this.b, this.c].sort((x,y) => x - y);
		const [x, y, z] = sides;
		const tolerance = 1e-10;
		return Math.abs(x**2 + y**2 - z**2) < tolerance;
	}

	calculatePoints() {
		const cosAlpha = (this.b**2 + this.c**2 - this.a**2)/(2*this.b*this.c);
		const posA = [this._x, this._y];
		const randomOffset = (Math.random() * 2 - 1) * Math.sqrt(this.c**2 - this.a**2);
		const posB = [this._x + this.c, this._y ];
		const Cx = (this.b * cosAlpha) + this._x;
		let Cy = Math.sqrt(this.a**2 - (Cx - this._x)**2) + this._y;
		if (isNaN(Cy)) {
			Cy = -Math.sqrt(this.a**2 - (Cx - this._x)**2) + this._y;
		}
		const posC = [Cx, Cy];
		return [posA, posB, posC];
	}
	
	
	changePosition() {
		super.changePosition();
		this._points = this.calculatePoints();
	}
	get points() {
		return this._points;
	}

	get perimeter() {
		return this.a + this.b + this.c;
	}
	get area() {
		const s = this.perimeter/2;
		return Math.sqrt(s*(s-this.a)*(s-this.b)*(s-this.c));
	}
	get type() {
		if (this.a === this.b && this.b === this.c) {
			return 'Equilateral';
		} else if (this.a === this.b || this.b === this.c || this.a === this.c) {
			return 'Isosceles';
		} else if (this.isRightTriangle()) {
			return 'Right Triangle'
		} else {
			return 'Scalene'
		}
	}

	giveValues() {
		return `Triangle -- Area: ${this.area} -- Perimeter: ${this.perimeter} -- Type: ${this.type}`;
	}
}

 class RegularPolygon extends AnimatedShape {
	constructor(x, y, [red, green, blue], xSpeed, ySpeed, side, numOfSides) {
		super(x, y, [red, green, blue], xSpeed, ySpeed)
		this._side = side;
		this._numOfSides = numOfSides;
	}
	set side(value) {
		if (value <= 0) {
			throw new Error('Side cannot be less than 0');
		} 
		this._side = value;
	} 
	set numOfSides(value) {
		if (value < 3) {
			throw new Error('Number of sides has to be greater than 3');
		}
		this._numOfSides = value;
	}
	get side() {
		return this._side;
	}
	get numOfSides() {
		return this._numOfSides;
	}
	get perimeter() {
		return this._side * this._numOfSides;
	}
	get area() {
		const aTop = this._numOfSides * Math.pow(this._side, 2);
		const aBot = 4 * Math.tan(Math.PI/this._numOfSides);
		return aTop / aBot;
	}
	giveValues() {
		return `Regular Polygon -- Area: ${this.area} -- Perimeter: ${this.perimeter} -- Number of Sides: ${this.numOfSides} -- Side: ${this.side}`
	}
}

const randomBetween = (min, max) => {
	return Math.random() * (max - min) + min;
}

// Beginning of rendering functions

const canvas = document.getElementById("canvas");
const ctx = canvas.getContext("2d");
const canvasWidth = canvas.width;
const canvasHeight = canvas.height;
const shapeArr = [];

const spawnShapes = (shapeType, numOfShapes) => {
	for (let i = 0; i < numOfShapes; ++i) {
		const randomXPosition = Math.random() * canvasWidth;
		const randomYPosition = Math.random() * canvasHeight;
		const randomColor = [Math.random()*255, Math.random()*255, Math.random()*255];
		const randomSpeed = Math.random() * 2;
		const randomSpeed2 = Math.random() * 2;
		if (shapeType === 'circle') {
			const randomRadius = Math.random() * 60;
			const randomStartAngle = 0;
			const randomEndAngle = Math.PI + (Math.PI * Math.floor(Math.random() * 3)) / 2;
			shapeArr.push(new Circle(randomXPosition, randomYPosition, randomRadius, randomStartAngle, randomEndAngle, randomColor, randomSpeed, randomSpeed2));
		} else if (shapeType === 'square') {
			const randomSide = Math.random() * 40;
			shapeArr.push(new Square(randomXPosition, randomYPosition, randomColor, randomSpeed, randomSpeed2, randomSide));
		} else if (shapeType === 'rectangle') {
			const randomLength = Math.random() * 40;
			const randomWidth = Math.random() * 40;
			shapeArr.push(new Rectangle(randomXPosition, randomYPosition, randomLength, randomWidth, randomColor, randomSpeed, randomSpeed2));
		} else if (shapeType === 'triangle') {
			const maxLength = Math.random() * 150;
			let randomA = randomBetween(0.01, maxLength);
			let randomB = randomBetween(0.01, maxLength);
			let randomC = randomBetween(Math.abs(randomA - randomB) + 0.01, randomA + randomB - 0.01);
				console.log(`
				Side A: ${randomA}
				Side B: ${randomB}
				Side C: ${randomC}
				`)
			shapeArr.push(new Triangle(randomXPosition, randomYPosition, randomColor, randomSpeed, randomSpeed2, randomA, randomB, randomC));
			
		} else if (shapeType === 'regularPolygon') {
			
		}
	}
}
const drawCircle = (shape) => {
	const [red, green, blue] = shape.color;
	ctx.fillStyle = `rgb(${red} ${green} ${blue})`			
	ctx.beginPath();
	ctx.arc(...shape.position, shape.radius, shape.startAngle, shape.endAngle)
	ctx.fill();
}
const drawRectangle = (shape) => {
	const [red, green, blue] = shape.color;
	ctx.fillStyle = `rgb(${red} ${green} ${blue})`
	if (shape instanceof Square) {
		ctx.fillRect(...shape.position, shape.side, shape.side);
	} else if (shape instanceof Rectangle) {
		ctx.fillRect(...shape.position, shape.width, shape.length);
	}
}
const drawTriangle = (shape) => {
	const [red, green, blue] = shape.color;
	ctx.fillStyle = `rgb(${red} ${green} ${blue})`

	ctx.beginPath();
	ctx.moveTo(...shape.points[0]);
	ctx.lineTo(...shape.points[1]);
	ctx.lineTo(...shape.points[2]);
	ctx.fill();
}


const animateShapes = () => {
	ctx.clearRect(0, 0, canvasWidth, canvasHeight);
	shapeArr.forEach(shape => {
		shape.changePosition();
		shape.checkBounding(canvas);
		if (shape instanceof Circle) {
			drawCircle(shape);
		} else if (shape instanceof Square) {
			drawRectangle(shape);
		} else if (shape instanceof Rectangle) {
			drawRectangle(shape);
		} else if (shape instanceof Triangle) {
			drawTriangle(shape);
			//console.log(shape.position);
		}
	});
	// IMPORTANT -- this is a recursive call for updated position, and the function to draw the shape object
	// at the new position. It also clears the canvas each time. 
	requestAnimationFrame(animateShapes);
}
// still need to make the drawTriangle functions
// - drawRegularPolygon
// - then we get into effects, lines

export { AnimatedShape, Circle, Square, Rectangle, Triangle, RegularPolygon, animateShapes, spawnShapes };
