// Quick Sort
// Complexity O(n log(n))
// Space Complexity: O(N);
// Summary: Divide and conquer. There are a few variants, all pick a pivot point that becomes the key that is compared to the preceding
// elements. 
// The elements less than the pivot are pushed into the "left" array, elements greater than the pivot are pushed to the "right" array. 
// Quicksort is called recursively on the subarrays until the input arrays are of length 1 or less.
// A new pivot is selected and the algorithm completes until every index has been sorted. 
// Quicksort is called recursively for every element in the input array.


const test_arr = [100, 22, 0, 150, 3, -5, 2, 66, 0];

function quickSort(arr) {
   const sorted = [...arr];
   if (sorted.length <= 1) {
      return sorted;
   }
   // pivot can be middle, 1st or last element, or random. Here it is the last el.  
   const pivot = sorted[sorted.length - 1];
   const left_arr = [];
   const right_arr = [];

   for (let i = 0; i < sorted.length - 1; ++i) {
      if (sorted[i] < pivot) {
         left_arr.push(sorted[i]);
      } else {
         right_arr.push(sorted[i]);
      }
   }
   return [...quickSort(left_arr), pivot, ...quickSort(right_arr)];
}

function fasterQuickSort(arr, left = 0, right = arr.length - 1) {
   if (left >= right) return arr;
   
   // Selecting random pivot, to help avoid N^2 time
   const pivot_index = Math.floor(Math.random() * (right - left + 1)) + left;
   // move pivot to the end
   [arr[pivot_index], arr[right]] = [arr[right], arr[pivot_index]];
   const pivot = arr[right];

   let i = left; // tracking the less than pivot boundary
   for (let j = left; j < right; ++j) {
      if (arr[j] < pivot) {
         [arr[i], arr[j]] = [arr[j], arr[i]]; // swaps if less than pivot
         ++i; // increment
      }
   }
   [arr[i], arr[right]] = [arr[right], arr[i]]; // move pivot to final place

   // Recursively sort left and right partitions, being kept track of w/ left and right values rather than separate arrays
   fasterQuickSort(arr, left, i - 1);
   fasterQuickSort(arr, i + 1, right);
   return arr;
}

// const sorted = quickSort(test_arr);
const sorted2 = fasterQuickSort([...test_arr]);

// console.log(sorted);
console.log(`faster: ${sorted2}`);
