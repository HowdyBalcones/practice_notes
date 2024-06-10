class Node {
	constructor(val, next) {
		this.val = val;
		this.next = null;
	}
}

const a = new Node('A')
const b = new Node('B')
const c = new Node('C')
const d = new Node('D')
const e = new Node('E')

a.next = b;
b.next = c;
c.next = d;
d.next = e;


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
	printLinkedListRec(head.next);
}

const linkListValues = (head) => {
	const values = [];
	let current = head;
	while (current !== null) {
		values.push(current.val);
		current = current.next;
	}
	console.log(values);
}

const linkListValuesRec = (head) => {
	const values = [];
	fillValues(head, values);
	return values;
}

const fillValues = (head, values) => {
	if (head === null) return;
	values.push(head.val);
	fillValues(head.next, values);
};

const sumList = (head) => {
	const current = head;
	let sum = 0;
	while (current !== null) {
		sum += current.val;
		current = current.next;
	}
	return sum;
};

sumListRec = (head) => {
	if (head === null) return 0;
	return head.val + sumListRec(head.next)
}
const searchLinkedList = (head, target) => {
        let current = head;
        while (current !== null) {
                if (current.val === target) {
                        return true;
        	}
	current = current.next;	
	}
	return false;
}
const searchLinkedListRec = (head, target) => {
	if (head === null) return false;
	if (head.val === target) return true;
	return 	searchLinkedListRec(head.next, target);
}

const getNodeValue = (head, index) => {
	let current = head;
	let count = 0;
	while (current !== null) {
		if (count === index) return current.val;
		count += 1;
		current = current.next;
	}
	return null;
}
const getNodeValueRec = (head, index) => {
	if (head === null) return null;
	if (index === 0) return head.val;
	return getNodeValueRec(head.next, --index);
}

const reverseLinkedList = (head) => {
	let current = head;
	let previous = null;
	while (current !== null) {
		const next = current.next;
		current.next = previous;
		previous = current;
		current = next;
	}
	return previous;
}
const reverseLinkedListRec = (head, previous = null) => {
	if (head === null) return previous;
	const next = head.next;
	head.next = previous;
	reverseLinkedListRec(next, head);
}

printLinkedList(a);
printLinkedListRec(a);
linkListValues(a);
linkListValuesRec(a);
console.log(searchLinkedList(a, 'D'));
console.log(getNodeValue(a, 7));
console.log(getNodeValueRec(a, 4));
console.log(reverseLinkedList(a));
