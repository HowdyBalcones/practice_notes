// Research 
// https://medium.com/@ethannam/understanding-the-levenshtein-distance-equation-for-beginners-c4285a5604f0
//


function lev_distance(string_1, string_2) {
   const len1 = string_1.length;
   const len2 = string_2.length;

   const matrix = Array(len1 + 1).fill(null).map(() => Array(len2 + 1).fill(0));
   // console.log(matrix);
   
   for (let i = 0; i <= len1; ++i) {
      matrix[i][0] = i;
   }
   
   for (let j = 0; j <= len2; ++j) {
      matrix[0][j] = j; 
   }

   for (let i = 1; i <= len1; ++i) {
      for (let j = 1; j <= len2; ++j) {
         const diff = (string_1[i - 1] === string_2[j - 1]) ? 0 : 1;
         matrix[i][j] = Math.min(
            matrix[i - 1][j] + 1,
            matrix[i][j - 1] + 1,
            matrix[i - 1][j - 1] + diff
         );
      }
   }

   return matrix[len1][len2];
}

function similarity(str1, str2, precision = 2) {
   const diff = 1 - (lev_distance(str1, str2) / Math.max(str1.length, str2.length));
   return diff.toFixed(precision);
}

function fuzzy_search(term, search_list, return_limit, max_diff=3) {
   term = term.toLowerCase();
   return search_list
      .map(item => ({
         original: item,
         normalized: item.toLowerCase(),
      }))
      .map(({ original, normalized }) => ({
         original,
         score: lev_distance(term, normalized)
      }))
      .filter(({ score }) => score <= max_diff)
      .sort((a, b) => a.score - b.score)
      .slice(0, return_limit)
      .map(({ original }) => original);
}

function main() {
   const test = lev_distance("Testing", "testing");
   const test2 = similarity("Testing", "Besting");
   const building = similarity("Building 1", "Building 70");
   const building2 = similarity("Building One", "Building Two");
   const level = similarity("Level 1", "Level 2");
   const fuzzy = fuzzy_search("Testing", ["Test", "Teting", "apple", "besting", "TESTING", "Testing"])
   console.log(`Building: ${building}`);
   console.log(`Building 2: ${building2}`);
   console.log(`Level: ${level}`)
   console.log(`Fuzzy: ${fuzzy[0]}, ${fuzzy[1]}`)
}

module.exports = { lev_distance, similarity, fuzzy_search }

// main();
