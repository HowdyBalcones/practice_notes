class DoubleNode {
   constructor(value) {
      this.value = value;
      this.next = null;
      this.prev = null;
   }

   setNextNode(node) {
      if (node instanceof DoubleNode || node === null) {
         this.next = node;
      } else {
         throw new Error("Next - not a double node.")
      }
   } 

   setPreviousNode(node) {
      if (node instanceof DoubleNode || node === null) {
         this.prev = node;
      } else {
         throw new Error("Previous - not a double node.")
      }
   }

   getNextNode() {
      return this.next;
   }

   getPreviousNode() {
      return this.prev;
   }
}

export { DoubleNode };
