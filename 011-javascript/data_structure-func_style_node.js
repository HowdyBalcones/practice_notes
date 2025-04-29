function make_node(data) {
   let node = {
      value: data,
      next: null
   };
   return node;
}

function make_stack(arr = []) {
   let stack = {
      items: [...arr] 
   };
   return stack; 
}

function peek_stack(stack) {
   return stack.items[stack.items.length - 1];
}

function is_stack_empty(stack) {
   return stack.items.length === 0;
}

const test_stack = make_stack([1,2,3,10]);
const wrong_stack = make_stack("str");

console.log(peek_stack(test_stack));
console.log(is_stack_empty(test_stack));

console.log(peek_stack(wrong_stack));
console.log(is_stack_empty(wrong_stack));

// const test_stack_empty = make_stack();
// console.log(`${test_stack.items.length} ${test_stack_empty.items.length}`);
//
// console.log(test_node.value + " " + test_node.next);

