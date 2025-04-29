import { LinkedList } from './data_structure-linked_list.js';

let test_list = new LinkedList();

// #1 Removing while empty
test_list.removeHead();

// #2 Adding to list
test_list.addToHead('one');
test_list.addToHead('two');
test_list.addToHead('three');
test_list.print();

// #3 Checking Tail
console.log(test_list.tail.value);

// #4 Adding to Tail
test_list.addToTail('zero');
test_list.print();

// #5 Search
console.log(test_list.searchByValue('three'))
