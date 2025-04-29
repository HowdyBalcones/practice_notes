class Node {
   constructor(value) {
      this.value = value;
      this.next = null;
   }

   setNextNode(node) {
      if (node instanceof Node || node === null) {
         this.next === node;
      } else {
         throw new Error("Not a node.");
      }
   }

   getNextNode() {
      return this.next;
   }
}

export { Node };
