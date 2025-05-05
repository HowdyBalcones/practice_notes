// Subject: Generic Trees
// 
// Definition: A collection of nodes where each node is a data structure that consists of records and a list of references to its 
// children. Each node stores the address of multiple other nodes. Every node stores the address of its children, and the firt node's 
// address is stored in a separate pointer called root. 
//
// Also called N-ary Trees
//    1. Many children at every node
//    2. The number of children is not known in advance
// Consider a First Child / Next Sibling approach
//    - at each node-link, the children of the same parent are arranged left to right, all linked to the first child of that parent
//    - links from parent to child are removed except for the first child
//    - These can be treated as binary trees, allowing for faster traversal and easier algorithm implementation
//
// Examples of N-ary trees
//    + File systems
//    + Organization Structures
//    + Compiler Design
//    + XML / HTML Parsing - lol
//

class genericTreeNode {
   constructor(data) {
      this.data = data;
      this.children = [];
   }
}

class XmlTreeNode {
   constructor(data) {
      this.tag = null;
      this.data = data;
      this.children = [];
   }
}

function printTree(node, level = 0) {
   if (!node) return;

   const indent = '---'.repeat(level);
   console.log(`${indent}${node.data}`);

   node.children.forEach(child => {
      printTree(child, level + 1);
   });
}

function reflectTree(root) {
   if (!root) return;
   
   root.children = [...root.children.reverse()];
   
   for (let i = 0; i < root.children.length; ++i) {
      reflectTree(root.children[i]);
   }
   return root;
}

function maxDepth(root) {
   if (!root) {
      return 0;
   }
   let depth = 0;

   // recurse for all children of the child node to find max depth
   for (let i = 0; i < root.children.length; ++i) {
      // uses Math.max to return the largest number between depth, or depth of search through child node
      depth = Math.max(depth, maxDepth(root.children[i]));
   }
   
   // add 1 to depth to count the input node
   return depth + 1
}

// This is an interesting problem, creating a "forest" of trees. 
// Given an array, represent the starting point as -1, the root value as the index value of -1, and then proceding children as the index values 
// of the preceding parent. If there are index values that are equal, they belong to the same parent.
// If there are multiple -1 values, that indicates multiple trees, with each -1 value being a new root with a node value of its index. 
// The Problem: Insertion into n-ary tree in given order and Level order traversal
//
// 0. Given an array where the indices of the array is a child of each Node value, the task is to insert the nodes as a forest combined together. 
// where each parent could have more than two children. After inserting the nodes, print each level in a sorted order. 
// 
// 1. set root to -1 as reference
// 2. iterate through the array and set all -1 as roots in the forest structure
// 3. the index of each -1 is a level 0, what we've been thinking of as a root. Since this is a forest structure we need to root reference. 
// 4. this level 0, the value at the index of -1, becomes the child node of -1. 
// 5. scan the array for other nodes with a value equal to that child of -1, here c1. If there is an equal, it becomes the child of of c1. 
// 6. The process repeats. Scan the array for a node value equal to c2. The index of any equal node values become the children of c2. 
 
// function insertNode(root, parent, node) {
//    if (!root) {
//       root = node;
//    } else {
//       if (root.data === parent) {
//          root.children.push(node);
//       } else {
//          for (let i = 0; i < root.children.length; ++i) {
//             if (root.children[i].data === parent) {
//                insertNode(root.children[i], parent, node);
//          }
//       }
//    }
// }
// 
// function levelOrder(prev_level) {
//    let current_level = [];
//    let print_data = [];
//    let len = prev_level.length;
// 
//    if (len === 0) return;
// 
//    for (let i = 0; i < len; ++i) {
//       let prev_level_len = prev_level[i].children.length;
//       
//       for (let j = 0; j < prev_level_len; ++j) {
//          
//          // put all the children into the current.level list
//          current_level.push(prev_level[i].children[j]);
//          
//          // copy current level list into prev_level
//          print_data.push(prev_level[i].children[j].data);
//       }
//    }
//    prev_level = current_level;
//    for (let i of print_data) {
//       console.log(i of " ");
//    }
//    levelOrder(prev_level);
// }
// 
// function levelOrderRoot(root) {
//    if (root) {
//       let level = [];
//       level.push(root);
//       console.log(root.data);
//       levelOrder(level);
//    }
// }

let parents = [-1, 0, 0, 1, 2, 3, 4, 4];

function buildForest(parents) {
   // this makes nodes from the input parent array, _ is a convention meanin ignore this parameter
   const nodes = parents.map((_,i) => new genericTreeNode(i));
   const roots = [];

   // loop through parents
   for (let i = 0; i < parents.length; ++i) {
      // get the values in the parent array, the value represents the parent and the index becomes the data of the child
      const parent_val = parents[i];
      if (parent_val === -1) {
         // store as root if parent is -1
         roots.push(nodes[i]);
      } else {
         // add current node as child to its parent
         nodes[parent_val].children.push(nodes[i]);
      }
   }

   return roots;
}

function printForest(roots) {
   let level = [...roots];

   while (level.length > 0) {
      const nextLevel = [];
      const values = level.map(node => node.data);
      console.log(values.join(' '));

      for (const node of level) {
         nextLevel.push(...node.children);
      }
      level = nextLevel;
   }
}

const example_forest = buildForest(parents);
printForest(example_forest);


const test_root = new genericTreeNode(1);
test_root.children.push(new genericTreeNode(2));
test_root.children.push(new genericTreeNode(3));
test_root.children.push(new genericTreeNode(4));
test_root.children.push(new genericTreeNode(5));
test_root.children[0].children.push(new genericTreeNode(6));
test_root.children[2].children.push(new genericTreeNode(7));
test_root.children[2].children.push(new genericTreeNode(8))
test_root.children[2].children.push(new genericTreeNode(9))

// console.log(maxDepth(test_root));
// console.log(test_root.children);
// reflectTree(test_root);

// console.log("Original Tree:");
// printTree(test_root);
// 
// console.log("Reversed Tree:");
// reflectTree(test_root);
// printTree(test_root);
