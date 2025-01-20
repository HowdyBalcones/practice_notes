let PROPERTY_NAME;

let test_obj = {
      "name": "Test Object",
      "response": "Hello World",
      "is_test": true,
      "is_real": false,
      "object_array": ["a", "b", "c", "d", "e"],
      "object_object": {"name": "interior_test_object", "big_justice":"boom"},
      "dimensions": {"width": 100, "height": 200},
      "positions": {"x": 150, "y": 250},
      1: "integer_property",
      2: "second_integer_property",
      "test_undefined": undefined,
      "test_null": null,
      "test_infinity": Infinity,
      "final": "last property",
      first_method: function () {return `${this.positions.x * this.dimensions.width}`},
      get final_property() {return this.final + "FINAL FINAL";},
      set final_property(value) {return this.final = value;}
};

let test_obj2 = {
   "name": "Test Object",
   1: "etc",
   2: "etcetc",
   "response": "Hello World",
   "object_array": ["a", "b", "c", "d", "e"],
   "test_undefined": undefined,
   "positions": {"x": 150, "y": 250}
}


let computed_test_object = {
   [PROPERTY_NAME]: 1
};

function object_test_each_property(object) {
   for (const name of Object.keys(object)) {
      console.log(name);
   }
}

function object_test_property_enumerable(object) {
   for (let p in object) {
      console.log(p);
   }
}

function object_tests(object) {
   const prototype_test = Object.create(test_obj);
   console.log(object);
   console.log(object.hasOwnProperty(1));
   console.log(prototype_test);
   console.log(new Object(), new Array(), new Date(), new Map()); // example of the comma operator working within a statement
   console.log(Object.hasOwn(object, "name"));
   object_test_each_property(object);
   console.log(Object.create(null));
   console.log(Object.create(Object.prototype));
   console.log(`${object.name}, ${object.final}`); // wondering why I can't call the integer properties of the object here
   console.log(object[1]);                         // must use object expression notation as in here
   console.log(object.name);                       // just putting this here for completeness
   console.log(object.name, object.response);
   object[3] = "new_property";                     // here we are defining a new object property
   console.log(object[3]);
   console.log(object[4]);                         // this property doesn't exist, will return undefined
   console.log(object.name?.name);                 // since name doesn't have a property name, returns undefined
   console.log(object?.name?.[1]);                 // here we use conditional chaining and obj. expression notation, returns "e"
   delete object.name;
   console.log(object?.name);                      // using delete keyword to remove a property
   delete object.toString();                       // this shouldn't work because delete only works on own properties
   console.log("name" in object);                  // name prop. is still deleted
   object.name = "Test Object";
   console.log("name" in object);                  // name prop. is restored, returns true 
   console.log("toString" in object);              // proving that delete only works on own properties...
   console.log("test1", object.hasOwnProperty("name"));
   console.log("test2", object.hasOwnProperty("toString"));
   console.log("test3", object.propertyIsEnumerable("name"));
   console.log("test4", object.propertyIsEnumerable("toString")); // some more tests on querying objects, eleborating on the own prop.
   object_test_property_enumerable(object); 
   const stringified_test_object = JSON.stringify(object);        // serialize and store an object in a variable
   console.log(stringified_test_object);
   console.log(JSON.parse(stringified_test_object));              // deserialize the object
   // remember that certain things are not desrializable, like dates or Infinity
   console.log(object.toString());                                // generic .toString() 
   console.log(object.toLocaleString());
   const date_test = new Date;
   console.log(date_test.toString());           // Date specific toString method
   console.log(date_test.toLocaleString());     // Date specific, localized toString method
   console.log(date_test.valueOf());
   console.log(date_test.valueOf() == date_test.valueOf());
   console.log(object.valueOf());
   console.log(computed_test_object[PROPERTY_NAME]);
   computed_test_object[PROPERTY_NAME] = "this is a computed property value";
   console.log(computed_test_object[PROPERTY_NAME]);
   console.log(...object.object_array);         // using the spread operator
   const placement = {...object.dimensions, ...object.positions};    // using spread operator to put objects into object
   console.log(placement);
   object.compute_area = function() {return object.dimensions.height * object.dimensions.width};   // create a property in a few ways
   // object[compute_random] = function() { return (Math.random()*100) + (Math.random*100) }; // this needs to be defined in the object
   console.log(object.compute_area());
   console.log(object.first_method());
   console.log(object.final_property);   
   console.log(object.final_property = "hello world");
   console.log(object.final_property);          // so don't use function invocation and the getters and setters work fine
}

// Querying Objects
// this will cover approaches for iterating over object keys

// standard for loop 

function object_key_for_loop (object) {
   // this uses the Object.keys builtin
   const keys = Object.keys(object);
   for (let i = 0; i < keys.length; ++i) {
      let key = keys[i];
      console.log(key);
   }
};

function object_key_direct_for_loop (object) {
   const total_keys = Object.keys(object).length;
   for (let i = 0; i < total_keys; ++i) {
      let key = Object.keys(object)[i];
      // this prints the object key, then searches the object for that key and prints its value
      console.log(`${key}: ${object[key]}`);
   }
}

function object_entries_for_loop (object) {
   // this uses the Object.entries builtin 
   const entries = Object.entries(object)
   for (let i = 0; i < entries.length; ++i) {
      // this leverages destructuring to assign key:value pairs to separate variables
      const [key, value] = entries[i];
      console.log(`${key}: ${value}`);
   }
};


// for in loops
function object_for_in_loop (object) {
   for (key in object) {
      console.log(key);
   }
}

function object_for_in_loop_own (object) {
// this one tests if the property is an own property of the object, rather than inherited
   for (const key in object) {
      if (object.hasOwnProperty(key)) {
         console.log(key);
      }
   }
}

// comparing objects with for..in 
// attempt 1!
function object_for_in_comparison (object1, object2) {
   for (const key1 in object1) {
      for (const key2 in object2) {
         if (key1 === key2) {
            console.log(true);
            continue;
         } else {
            console.log(false);
            continue;
         }
      }
   }
}

// puts the keys of the object into an array, compares the key array lengths, then compares keys 
function object_comparison_shallow (object1, object2) {
   const keys1 = Object.keys(object1);
   const keys2 = Object.keys(object2);

   if (keys1.length !== keys2.length) return false;
   for (const key of keys1) {
      if (object1[key] !== object2[key]) return false;
   }
   return true;
}

// recursively calls on sub-objects and compares the keys between parent objects. 
// can be very expensive depending on the level of nesting.
function object_comparison_expensive (object1, object2) {
   if (object1 === object2) return true;
   if (typeof object1 !== "object" || typeof object2 !== "object" || object1 === null || object2 === null) return false;
   const keys1 = Object.keys(object1);
   const keys2 = Object.keys(object2);
   if (keys1.length !== keys2.length) return false;

   // this uses includes to check the keys2 array for a key of key1 array, if returns true then call parent func on the key 
   // to ensure nested objects are compared to each other.
   for (const key of keys1) {
      if (!keys2.includes(key) || !object_comparison_expensive(object1[key], object2[key])) {
         return false;
      }
   }
   return true;
}


function object_compare_properties (object1, object2, property) {
   if (!object1[property] && !object2[property]) return false;
   if (object1[property] === object2[property]) return true;
   return false;
}


function destructuring_demonstration () {
   const test = {"one":"two", "three":"four"};
   for (const [property1, value1] of Object.entries(test)) {
      console.log(property1, value1);
   }
   const arr = [1, 2, 3, 4 ,5, 6];
   const [one, two, three, four, five, six] = arr;
   console.log(one, two, three, four, five, six); 
}

// object_tests(test_obj);
// object_key_for_loop(test_obj);
// object_key_direct_for_loop(test_obj);
// destructuring_demonstration();
// object_entries_for_loop(test_obj);
// object_for_in_loop(test_obj);
// object_for_in_loop_own(test_obj);
// object_for_in_comparison(test_obj, test_obj2);
// console.log(object_comparison_shallow(test_obj, test_obj));
// console.log(object_comparison_expensive(test_obj, test_obj2));
console.log(object_compare_properties(test_obj, test_obj2, "name"));
