let stack = [];

stack.push("Apple");
stack.push("Banana");
stack.push("Cherry");
// popping items off of a stack
// let poppedItem = stack.pop();
// console.log(poppedItem);

// viewing top item of stack without removing
// let topItem = stack[stack.length - 1];
// console.log(topItem);

function isStackEmpty(stack)
{
	return stack.length === 0;
}
// console.log(isStackEmpty(stack));

// checking stack length
// let stackLength = stack.length;
// console.log(stackLength);

class Stack 
{
	constructor() {
		this.items = [];
	}
	push(element) {
		this.items.push(element);
	}
	pop() {
		if (this.items.length === 0) return "Underflow";
		return this.items.pop();
	}
	peek() {
		return this.items[this.items.length - 1];
	}
	isEmpty() {
		return this.items.length === 0;
	}
	size() {
		return this.items.length;
	}
	printStack() {
		console.log(this.items.toString());
	}
}
const myStack = new Stack();
myStack.push("Apple");
myStack.push("Carrot");
myStack.push("PineApple");
myStack.printStack();
console.log(myStack);
console.log(stack);
