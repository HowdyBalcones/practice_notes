// Merge Sort 
//
// Complexity: Best O(log(n)) Worst O(n log(n))
// Summary: Divide and Conquer solution, recursively divides input array into two halves then merges elements back together
//
// Stage 1: Divide input list recursively until it cannot be divided further. 
// Stage 2: Subarrays are sorted using the merge sort algorithm
// Stage 3: Subarrays are recombined using a merge helper function

const test_arr = [5, 10, -4, 0, 12, 100, 0.03];



function mergeSort(arr) {

   function merge(left, right) {
      let sorted_arr = [];
      while (left.length && right.length) {
         if (left[0] < right[0]) {
            sorted_arr.push(left.shift());
         } else {
            sorted_arr.push(right.shift());
         }
      }
      return [...sorted_arr, ...left, ...right];
   }
   
   // Base case, exit condition
   if (arr.length <= 1) return arr;
   let mid = Math.floor(arr.length / 2);

   let left = mergeSort(arr.slice(0, mid)); // return left half of arr
   // console.log(left);
   let right = mergeSort(arr.slice(mid));   // return right side of arr
   // console.log(right);

   return merge(left, right);
}

// const sorted_arr = mergeSort(test_arr);

export { mergeSort };
