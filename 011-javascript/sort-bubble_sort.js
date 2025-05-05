// Bubble Sort
// Time Complexity: O(n^2)
// Used often in examples but it's not efficient. 

// Summary: Used for sorting lists, compares 0 index to next element, if it's greater than
// they are swapped, if it's less than nothing happens. This can be inverted. 

const test_arr = [5, 10, -4, 0, 12, 100];

function bubble_sort(arr) {
   let sorted = [...arr];
   for (let i = 0; i < sorted.length; ++i) {
      for (let j = 0; j < sorted.length - i - 1; ++j) {
         if (sorted[j] > sorted[j + 1]) {
            [sorted[j], sorted[j + 1]] = [sorted[j + 1], sorted[j]];
         }
      }
   }
   return sorted;
}

export { bubble_sort };
