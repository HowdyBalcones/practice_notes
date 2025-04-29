class PriorityQueue {
   constructor() {
      this.items = [];
   }

   enqueue(element, priority) {
      const queue_element = { element, priority };
      let added = false;

      for (let i = 0; i < this.items.length; ++i) {
         if (queue_element.priority < this.items[i].priority) {
            this.items.splice(i, 0, queue_element);
            added = true;
            break;
         }
      }
      
      if (!added) {
         this.items.push(queue_element);
      }
   }

   dequeue() {
      if (this.isEmpty()) {
         return null;
      }
      return this.items.shift().element;
   }

   peek() {
      if (this.isEmpty()) {
         return "queue is empty";
      }
      return this.items[0].element;
   }

   reverse() {
      return [...this.items].reverse();
   }

   isEmpty() {
      return this.items.length === 0;
   }
}

export { PriorityQueue };
