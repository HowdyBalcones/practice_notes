import { Stack, Queue, PriorityQueue, ListNode, LinkedList  } from './dataStructs.js';

const myStack = new Stack();
let name1 = myStack.push("Johnny");
let name2 = myStack.push("Karen");
let name3 = myStack.push("Frenchie");

const myQueue = new Queue();
let person1 = myQueue.enqueue("Customer1");
let person2 = myQueue.enqueue("Customer2");
let person3 = myQueue.enqueue("Customer3");

// Priority Queue
const myPrioQueue = new PriorityQueue();
let student1 = myPrioQueue.enqueue("Sara", "A");
let student2 = myPrioQueue.enqueue("Billy", "D");
let student3 = myPrioQueue.enqueue("Karen", "B");

// const myList = new LinkedList();


console.log(myPrioQueue);
console.log(myPrioQueue.reverse());
console.log(myQueue.front());
console.log(myStack);
