// Insertion Sort
// Complexity: Best O(n) when it's already sorted, Worst and Average O(n^2) 
// Space Complexity: O(1), very efficient space wise
// Summary: Starts at index 1 of an array, compares the previous index against the key index, swaps/shifts them if k-1 is greater than k
// procedes through the entire array in this fashion. 

let test_array = [1, 100, 5, 48, 29, 0, -4];

function insertionSort(arr) {
   let sorted_arr = [...arr];
   for (let i = 1; i < sorted_arr.length; ++i) {
      let key = sorted_arr[i];
      let j = i - 1;
      
      // swap happens in here, moving the larger element up through the array so long as it's greater than the key
      while (j >= 0 && sorted_arr[j] > key) {
         sorted_arr[j + 1] = sorted_arr[j];  // swap j w/ key if j is greater
         j = j - 1;                          // decrement j
      }
      sorted_arr[j + 1] = key;               // move the key up for further comparison
   }
   return sorted_arr;
}

export { insertionSort };
