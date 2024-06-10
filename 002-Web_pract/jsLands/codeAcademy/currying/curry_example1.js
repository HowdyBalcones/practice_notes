function curried_add(a) {
	return function nested_func(b) {
		return a + b;
	}
}

let add_one = curried_add(5);
console.log(add_one(1));
