// making a stack class
// constructor, put items onto stack (push), take something off top of stack (pop), 
// check what is on top of stack (peek), check if the stack is empty

// NOTES
// - Abstract Data type -
// abstraction of a data structure which provides only the interface to which a data structure must adhere to
// The interface does not give any specific details about how something should be implemented or what language
//
// - Computational Complexity -
// How much time, how much space, does any given algorithm take? 

// - Big-O Notation - 
// gives the upper bound of complexity in a worst case example
// n = input of algorithm 
// Constant Time - O(1)
// Logorithmic Time - O(log(n))
// Linear Time - O(n)
// Linearithmic Time - O(nlog(n))
// Quadric Time: O(n^2)
// Cubic Time - O(n^3)
// Exponential Time - O(b^n), b > 1
// Factorial Time - O(n!)
//



class Stack 
{
	constructor() {
		this.items = [];
	}

	push(item) {
		this.items.push(item);
	}

	pop() {
		if (this.items.length === 0) {
			return "Underflow";
		}
		return this.items.pop();
	}

	peek() {
		return this.items[this.items.length - 1];
	}

	isEmpty() {
		return this.items.length === 0;
	}
}

// FIFO, like a line at the drive through. 
// enqueue places something into the line, dequeue takes something off the front of the line,
// front checks what's at the front of the line, isEmpty checks if the queue is empty

class Queue 
{
	constructor() {
		this.items = [];
	}

	enqueue(items) {
		this.items.push(items);
	}

	dequeue() {
		if (this.isEmpty()) {
			return "Underflow";
		}
		return this.items.shift();
	}

	front() {
		if (this.isEmpty()) {
			return "This queue is empty";
		}
		return this.items[0];
	}

	isEmpty() {
		return this.items.length === 0;
	}
}

class PriorityQueue
{
	constructor() {
		this.items = [];
	}

	enqueue(element, priority) {
		// this is the element object
		const queueElement = { element, priority };
		let added = false;
		
		for (let i = 0; i < this.items.length; i++) {
			if (queueElement.priority < this.items[i].priority) {
				this.items.splice(i, 0, queueElement );
				added = true;
				break;
			}
		}
		
		if (!added) {
			this.items.push(queueElement);
		}
	}

	dequeue() {
	// remove and return the first element in the queue
		if (this.isEmpty()) {
			return "Underflow";
		}
		return this.items.shift().element;
	}

	front() {
		if (this.isEmpty()) {
			return "The queue is empty.";
		}
		return this.items[0].element;
	}
	
	reverse() {
		const reversedItems = [];
		for (let i = this.items.length - 1; i >= 0; --i) {
			reversedItems.push(this.items[i].element);
		}
		return reversedItems;
	}

	isEmpty() {
		return this.items.length === 0;
	}
}

class ListNode 
{
	constructor(value) {
		this.value = value;
		this.next = null;
	}
}

class LinkedList 
{
	constructor() {
		this.head = null;
		this.tail = null;
	}

	add(value) {
		const newNode = new ListNode(value);
		if (!this.head) {
			this.head = this.tail = newNode;
			return;
		} else {
			this.tail.next = newNode;
			this.tail = newNode;
		}
	

		}
	print() {
		let current = this.head;
		while (current) {
			console.log(current.value);
			current = current.next;
		}
	}

}

class DoublyLinkedNode 
{
	constructor(value) {
		this.value = value;
		this.next = null;
		this.prev = null;
	}
}

class DoublyLinkedList
{
	constructor() {
		this.head = null;
		this.tail = null;
	}

	// apply node to the end of a list
	append (value) {
		const newNode = new DoublyLinkedNode(value);
		if (this.tail === 0) {
			this.head = this.tail = newNode;
		} else {
			newNode.prev = this.tail;
			this.tail.next = newNode;
			this.tail = newNode;
		}
	}

	// apply node to the beginning of a list
	prepend(value) {
		const newNode = new DoublyLinkedNode(value);
		if (this.head === null) {
			this.head = this.tail = newNode;
		} else {
			newNode.next = this.head;
			this.head.prev = newNode;
			this.head = newNode;
		} 
	}

	// delete() {
	//
	// }
	
	// search() {
	//
	// }
	
}

export { Stack, Queue, PriorityQueue, ListNode, LinkedList, DoublyLinkedNode, DoublyLinkedList  };
