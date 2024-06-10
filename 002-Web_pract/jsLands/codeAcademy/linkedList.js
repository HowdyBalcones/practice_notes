class Node {
	constructor(val) {
		this.val = val;
		this.next = null;
	}
}

const a = new Node('A');
const b = new Node('B');
const c = new Node('C');
const d = new Node('D');

a.next = b;
b.next = c;
c.next = d;

// A -> B -> C -> D -> NULL

 const printLinkedList = (head) => {
 	let current = head;
 	while (current !== null) {
 		console.log(current.val);
 		current = current.next;
 	}
 };
const printLinkedListRec = (head) => {
	if (head === null) return;
	console.log(head.val);
	printLinkedList(head.next);
};
const linkedListValues = (head) => {
	let current = head;
	const values = []
	while (current !== null) {
		values.push(current.val);
		current = current.next;
	}
	console.log(values);
}

const linkedListValuesRec = (head) => {
	const values = [];
	fillValues(head, values);
	return values;
};
const fillValues(head, values) => {
	if (head === null) return;
	values.push(head.val);
	fillValues(head.next);
};
const searchLinkedList = (head, target) => {
	let current = head;
	while (current !== null) {
		if (current.val === target) {
			return head.val;
		} else if (current.val !== target) {
			current = head.next;
		}
	}
}


printLinkedList(a);
linkedListValues(a);
searchLinkedList(a, d)
