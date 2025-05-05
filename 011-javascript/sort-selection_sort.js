// Selection Sort
// Complexity: O(n^2)
// Space Complexity: O(1)
// Summary: Assume i is your first min value, find the actual minimum value in an array, swap the new min with i, repeat for each arr el
// Is not stable, meaning the relative order of equal elements is not preserved.
// It is only beat out by cycle sort in fewest average number of memory writes, so can be used when memory writes are costly

const test_arr = [77,0.03,42,100,1,150,0];

function selectionSort(arr) {
   let sorted = [...arr];
   let n = sorted.length;

   for (let i = 0; i < n - 1; ++i) {
      let min = i;
      // real min is found w/ inner loop
      for (let j = i + 1; j < n; ++j) {
         if (sorted[j] < sorted[min]) {
            min = j;
         }
      }
      // swap happens here
      // console.log(sorted);
      let temp = sorted[i];
      sorted[i] = sorted[min];
      sorted[min] = temp;
   }
   return sorted;
}

export { selectionSort };
