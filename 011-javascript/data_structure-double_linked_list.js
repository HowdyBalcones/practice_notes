import { DoubleNode } from './data_structure-double_node.js';

class DoubleLinkedList {
   constructor() {
      this.head = null;
      this.tail = null;
      this.size = 0;
   }

   addToHead(value) {
      const new_head = new DoubleNode(value);
      const current_head = this.head;
      
      if (current_head) {
         current_head.setPreviousNode(new_head);
         new_head.setNextNode(current_head);
      }
      this.head = new_head;
      this.size++;
      if (!this.tail) {
         this.tail = new_head;
      }
   }

   addToTail(value) {
      const new_tail = new DoubleNode(value);
      const current_tail = this.tail;
      
      if (current_tail) {
         current_tail.setNextNode(new_tail);
         new_tail.setPreviousNode(current_tail);
      }
      this.tail = new_tail;
      this.size++;
      if (!this.head) {
         this.head = new_tail;
      } 
   }

   // recursively search the list for a node value
   find(value, current_node = this.head) {
      if (current_node === null) {
         return null;
      } else if (current_node.value === value) {
         return current_node;
      } else {
         return this.find(value, current_node.next);
      }
   }

   // remove the first element of the list, initialize the new element.
   removeHead() {
      if (!this.head) {
         return null;
      }
      
      const removed_head = this.head;
      this.head = removed_head.getNextNode();

      if (this.head) {
         this.head.setPreviousNode(null);
      }
      removed_head.setNextNode(null);
      this.size--;
      if (removed_head === this.tail) {
         this.tail = null;
      }

      return removed_head.value;
   }

   removeTail() {
      if (!this.tail) {
         return null;
      }

      const removed_tail = this.tail;
      this.tail = removed_tail.getPreviousNode();

      if (this.tail) {
         this.tail.setNextNode(null);
      }
      removed_tail.setPreviousNode(null);
      this.size--;
      if (removed_tail === this.head) {
         this.head = null;
      }
      return removed_tail.value;
   }

   removeByValue(value) {
      let node_to_remove;
      let current_node = this.head;
      while (current_node !== null) {
         if (current_node.value === value) {
            node_to_remove = current_node;
            break;
         }
         current_node = current_node.getNextNode();
      }
      if (!node_to_remove) {
         return null;
      }
      if (node_to_remove === this.head) {
         this.removeHead();
      } else if (node_to_remove === this.tail) {
         this.removeTail();
      } else {
         const next_node = node_to_remove.getNextNode();
         const previous_node = node_to_remove.getPreviousNode();
         next_node.setPreviousNode(previous_node);
         previous_node.setNextNode(next_node);
      }
      this.size--;
      return node_to_remove;
   }

   printList() {
      let current_node = this.head;
      let output = '<head> ';
      while (current_node !== null) {
         output += `${current_node.value} `;
         current_node = current_node.getNextNode();
      }
      output += '<tail>';
      console.log(output);
   }
}

export { DoubleLinkedList };
