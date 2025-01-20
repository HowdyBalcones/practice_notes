// function expressions are not hoisted as typical functions are. 
const func_expression = function() { console.log("This is a function expression") };
const arrow_func_example = () => console.log("hello world");
const arrow_func_example2 = (x,y) => console.log(`${x} + ${y} = ${x+y}`);

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
