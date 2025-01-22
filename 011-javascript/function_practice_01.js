// function expressions are not hoisted as typical functions are. 
const func_expression = function() { console.log("This is a function expression") };
const arrow_func_example = () => console.log("hello world");
const arrow_func_example2 = (x,y) => console.log(`${x} + ${y} = ${x+y}`);
const test_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

function traditional_func () {
   console.log("The good old days");
}


function func_sub_func(x, y) {
   console.log("This function has sub functions");
   console.log(`${x} and ${y} parameters`)
   function sub_func_one(x, y) {
      console.log(`${x} * ${y} = ${x*y}`);
   }
   return sub_func_one;
}

function func_method_chaining(x,y) {
   console.log(`Initial paramters: ${x}, ${y}`);
   // this returns an object that has methods that are within the parent functions scope 
   return {
      sub_func_one: function (a, b) {
         console.log(`${a} * ${b} = ${a*b}`);
         return this;
      },
      sub_func_two: function (a, b) {
         console.log(`${a} + ${b} = ${a+b}`);
         return this;
      }
   };
}

const understanding_this_in_func = {
   name: "Alice",
   hobbies: ["reading", "coding"],
   describe_hobbies() {
      // .this refers to the parent object scope
      console.log(`${this.name}'s hobbies:`);
      // here is the nested function
      this.hobbies.forEach(function(hobby) {
         // .this is now the global object, and not the parent object 
         console.log(`${this.name} loves ${hobby}`);
      });
   }
};

const solution_func_scope_arrow_func = {
   name: "Alice",
   hobbies: ["reading", "coding"],
   describe_hobbies() {
      console.log(`${this.name}'s hobbies:`);
      this.hobbies.forEach(hobby => {
         console.log(`${this.name} loves ${hobby}`);
      });
   }
};

const solution_func_scope_bind = {
   name: "Alice",
   hobbies: ["reading", "writing functions"],
   describe_hobbies() {
      console.log(`${this.name}'s hobbies:`)
      this.hobbies.forEach(function(hobby) {
         console.log(`${this.name} loves ${hobby}`);
      }.bind(this)); // this should fix .this context 
   }
};

const solution_func_scope_stored_reference = {
   name: "Alice",
   hobbies: ["reading", "javascript"],
   describe_hobbies() {
      console.log(`${this.name}'s hobbies:`);
      const self = this;
      this.hobbies.forEach(function(hobby) {
         console.log(`${self.name} loves ${hobby}`);
      });
   }
};

function using_rest_parameter(x,y, ...rest) {
   // rest becomes an array within the functions execution context.
   let initial_sum = x + y;
   let product = 0;
   for (let num of rest) {
      product += initial_sum * num;
   }
   console.log(product, rest.length);
}

function using_spread_operator(array) {
   console.log(...array);
   console.log(`${Math.min(...array)} & ${Math.max(...array)}`);


}

understanding_function_properties.previous = [];
function understanding_function_properties (integer_value) {
   let computed_value = integer_value * Math.floor(Math.random() * 100);
   if (understanding_function_properties.previous.length >= 100) return;
   if (!understanding_function_properties.previous.includes(computed_value)) {
      understanding_function_properties.previous.push(computed_value);
      return computed_value;
   }
   return understanding_function_properties(integer_value);
} 

function test_understanding_function_properties(integer_amount) {
   for (let i = 0; i < integer_amount; ++i) {
     console.log(understanding_function_properties(10));
   }
}



arrow_func_example();
arrow_func_example2(20, 10);
traditional_func();
const testing_sub_functions = func_sub_func(400, 20);
testing_sub_functions(2, 8);

func_method_chaining(4, 10)
   .sub_func_one(40, 100)
   .sub_func_two(400, 1000);

func_expression();
understanding_this_in_func.describe_hobbies(); // this will have some undefined properties logged, because we are demonstrating losing scope
solution_func_scope_arrow_func.describe_hobbies();
using_rest_parameter(2, 2, 10, 10, 10);
using_spread_operator(test_array);
test_understanding_function_properties(100);
