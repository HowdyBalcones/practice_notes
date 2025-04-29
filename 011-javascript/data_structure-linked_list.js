import { Node } from './data_structure-node.js';

class LinkedList {
   constructor() {
      this.head = null;
      this.tail = null;
   }

   // apply a node to the end of the list
   addToTail(value) {
      const new_node = new Node(value);
      if (!this.head) {
         this.head = this.tail = new_node;
         return;
      } else {
         this.tail.next = new_node;
         this.tail = new_node;
      }
   }

   // apply a node to the beginning of a list
   addToHead(value) {
      const new_node = new Node(value);
      if (!this.head) {
         this.head = this.tail = new_node;
      } else {
         new_node.next = this.head;
         this.head = new_node;
      }
   }

   removeHead() {
      if (!this.head) {
         return null;
      }
      const removed_head = this.head;
      this.head = removed_head.next;
      if (!this.head) {
         this.tail = null;
      }
      return removed_head;
   }

   searchByValue(value) {
      let current = this.head;
      while (current) {
         if (current.value === value) {
            return current;
         } else {
            current = current.next;
         }
      }
      return null;
   }
   
   print() {
      let current = this.head;
      while (current) {
         console.log(current.value);
         current = current.next;
      }
   }

   isEmpty() {
      return this.head === null;
   }
}

export { LinkedList };
