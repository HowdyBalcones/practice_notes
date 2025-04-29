import { DoubleLinkedList } from './data_structure-double_linked_list.js';

let test_list = new DoubleLinkedList();

// DS Tests 

// #1 Empty Lists
console.log(test_list.removeHead()); // null
console.log(test_list.removeTail()); // null

// #2 Single Node
test_list.addToHead('one');
console.log(test_list.removeTail()); // one
console.log(test_list.head);         // null

// #3 Remove by Value
test_list.addToTail('A');
test_list.addToTail('B');
test_list.addToTail('C');
test_list.removeByValue('B');
test_list.printList();

// #4 Size tracking
console.log(test_list.size); // 2
test_list.removeHead();
console.log(test_list.size); // 1

// #5 Edge Case - size = 1
test_list.removeTail();
console.log(test_list.size);


// My basic tests
// test_list.addToTail('one');
// test_list.addToTail('two');
// test_list.addToTail('three');
// 
// test_list.removeTail();
// test_list.removeHead();
// test_list.addToHead('four');
// test_list.removeByValue('two');
// test_list.addToHead('three');
// test_list.addToHead('two');
// test_list.addToHead('one');
// test_list.removeHead();
// test_list.removeTail();
// test_list.removeByValue('one');

// console.log(test_list.head);
// test_list.printList();
