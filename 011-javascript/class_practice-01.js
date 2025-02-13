// example of a classic factory function in JS

function range_fact(from, to) {
   let rf = Object.create(range_fact.methods);
   rf.from = from;
   rf.to = to;
   return rf;
}

range_fact.methods = {
   includes(x) { return this.from <= x && x <= this.to },
   *[Symbol.iterator]() {
      for (let x = Math.ceil(this.from); x <= this.to; ++x) yield x;
   },
   toString() { return `(${this.from}...${this.to})`;}
};

let a_range = range_fact(1,10);
console.log(a_range.includes(5));
console.log(a_range.includes(0));
console.log([...a_range]);

// this is a classic JS constructor function
function Range(from, to) {
   this.from = from;
   this.to = to;
}

Range.prototype = {
   includes: function(x) { return this.from <= x && x <= this.to },
   [Symbol.iterator]: function*() {
      for (let x = Math.ceil(this.from); x <= this.to; ++x) yield x;
   }, 
   toString: function() { return `(${this.from}...${this.to})`; }
};

let constructor_range = new Range(1,10);
console.log(constructor_range.includes(1));
console.log(constructor_range.includes(0));
console.log([...constructor_range]);

// Important Concepts:
// 1. Symbol.iterator is getting added as a method to the range objects in this example. 
// The iterator is going through each value between the given arguments and evaluating. 
// 2. Yield is used to produce a value and pause execution until the next value is processed. 
// 3. *[Symbol.iterator] and [Symbol.iterator]: function*() are both Generator Functions. 


class Testing {
   field1 = "Field 1";
   field2 = 200;
   field3 = null;
   constructor(string) {
      this.string = string !== undefined ? string : "No string provided.";
   }
   say_something() { return this.string };
   say_your_mom() { return `Your Mom, and ${this.string}` };
}

class Not_Testing {
   constructor(string) {
      this.string = string !== undefined ? string : "No string provided.";
   }
   not_testing() { return this.string };
   not_saying_your_mom() { return `Your Mom, and ${this.string}` };
}

const testing_obj = {
   name: "testing",
   year: Date()
}

let testing_obj2 = new Object(testing_obj);

let hw = new Testing("Hello World");
let not_hw = new Not_Testing("Hello Solar System");

// using instanceof
console.log(not_hw instanceof Not_Testing);
console.log(not_hw instanceof Testing);

// using methods defined in class
console.log(hw.say_something());
console.log(hw.say_your_mom());

// testing objects and prototype chains
console.log(new Testing());
console.log(testing_obj.year);
console.log(testing_obj2);

// testing static fields in classes
console.log(hw.field1, hw.field2, hw.field3);

// viewing the prototype of a class or object
console.log(Object.getPrototypeOf(hw));
console.log(Object.getPrototypeOf(testing_obj));
console.log(Object.getPrototypeOf(testing_obj2))


