import { LinkedList } from './data_structure-linked_list.js';

class Stack {
   constructor(max_size = Infinity) {
      this.stack = new LinkedList();
      this.max_size = max_size;
      this.size = 0;
   }
   
   hasRoom() {
      if (this.size < this.max_size) {
         return true;
      } else {
         return false;
      }
   }

   push(value) {
      if (this.hasRoom()) {
         const value = this.stack.addToHead();
         ++this.size;
         return value;
      } else {
         throw new Error('Stack is full');
      }
   }

   pop() {

   }

   isEmpty() {
      return this.size === 0;
   }
}
