// a quicksort function i saw on youtube.
// typescript syntax, parameter is an array of numbers, that returns an array of numbers
function quicksort(arr: number[]): number[] {
	// the base case, this function uses recursion, 
	// without this it would infinitely recur
	//
	if (arr.length === 0) {
		return [];
	}
	const pivot = arr[0];
	const left = arr.slice(1).filter(x => x < pivot);
	const right = arr.slice(1).filter(x => x >= pivot);
	return quicksort(left).concat([pivot]).concat(quicksort(right));
}
