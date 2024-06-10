const curried_add = a => b => a + b;
let add_one = curried_add(1);
console.log(add_one(10));

