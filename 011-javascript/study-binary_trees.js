/* *

This is compendium of notes on binary trees, one of the fundamental tree types. 
We are referencing a few sources for the specific problems, but the main reference is: https://www.geeksforgeeks.org/types-of-trees-in-data-structures/

We start with the basics, split up by the different problems and sections in the reference. 

 * */

// Chapter 0: Intro to Binary Trees
// https://www.geeksforgeeks.org/introduction-to-binary-tree/
//
// A binary tree is a data structure where each node has at most two children, the left and right child. The topmost node is the root, and the bottom most nodes are leaves.
//
// -- Definitions
// nodes - fundamental structure that makes up a binary tree, contains data and two links to left and right child
// root - the topmost node in a tree is known as the root, serving as the starting point for any given tree, either the whole tree or any sub trees
// parent node - a node that has one or more child nodes. In a binary tree each node can have at most two children
// child node - a node that is a descendant of another node, has a parent
// Leaf node - a node with a parent but no child node, here both children would be null;
// internal node - a node that has at least one child node that is not null, this includes all nodes except the leaf nodes
// depth of a ndoe - the numer of edges from a specific node to the root node, depth of the main root is 0
// height of a binary tree - the number of nodes from the deepest leaf node to the root node

// Advantages: 
// Efficient Search - each node has at most two node compared to a linked list or array
// Memory Efficient - Binary Trees require less memory as compared to other tree data structures
// Simplicity - Binary trees are a fundamental data structure in many applications, and they are relatively easy to understand the basics of for implementation
// Balanced Storage - variants like AVL and Red/Black ensure balanced performance
// Flexibility - Adaptable to various specialized structures
// Naturally aligned with Recursive Algorithms
// Scalable, suitable for large dynamic datasets.
//
// Disadvantages: 
// Limited Structure - since a node can only have at most two children, a different tree structure might need to be used
// Unbalanced Trees - when a subtree is significantly larger than the other, it can lead to inefficient search operations.
//                    This can occur when the tree is not properly balanced or data is inserted in a non-random order.
// Space Efficiency - Can be space inefficient because each node requires two child references or pointers, this can be a significant overhead for large trees.
// Slow in worst cases - a Binary Tree can become degenerate or skewed, meaning that each node has only one child. In this case, search operations in 
//                       a Binary Search Tree (variation of binary tree) can degrade to O(n) time complexity, where n is the nubmer of nodes in the tree. 

// -- Applications 
// DOM and HTML - Help manage hierarchichal structure of web pages. 
// File Explorer - Organize file systems for efficient navigation.
// Expression Evaluation - Used in calculators and compilers to evaluate arithmetic expressions.
// Routing Algorithms - Supports decision making in network routing.
// General Application - they are used all over the place, its a fundamental data structure.

// Hierarchichal Data Representation 
// File systems and Folder Structures
// Organizational charts
// XML/HTML/ Parsing - Process structured data in documents

// Use in BSTs (Binary Search Trees)
// Efficient operations, searching, insertion, deletion. O(Log n)
// Also supports sorted traversal, floor and ceil
// Search / Insert / Delete are faster than linked lists but slower than hashes, but hashes don't allow for sorted traversal.
// Allow for implementing associative arrays, maps, and sets while keeping data sorted.

// Use in Binary Heap Trees
// Expression Trees - Represent arithmetic expressions where internal nodes are operators and leaf nodes are operands. Compilers / Calculators
// Huffman Coding Trees - Essential in data compression
// Decision Trees - machine learning, conditional processes 
// Traversal Operations - Preorder, inorder, postorder traversals aid in tasks like expression evaluation and tree reconstruction

// -- Properties > https://www.geeksforgeeks.org/properties-of-binary-tree/
// the maximum number of nodes at level L of a binary tree is 2^L
// the max number of nodes in a binary tree of height H is 2^H-1
// Total number of leaf nodes in a binary tree = total number of nodes with 2 children + 1 -- is this correct? 
// In a binary tree with N nodes, the minimum possible height or the minimum number of levels is Log2(N+1)
// A binary tree with L leaves has at least |Log2L|+1 levels

// -- Types of Binary Trees
//
// Based on number of children
// 1. Full Binary Tree 
//    + a binary tree is full if every node has 0 or 2 children. Another definition, a binary tree where every node except leaf nodes have 2 children.
//    + Also known as a proper binary tree. 

// 2. Degenerate / Pathological Binary Tree
//    + a tree where every node has one child. Performance wise, these trees are the same as a linked list. 
//    + each individual tree can have its one child either right or left. 

// 3. Skewed Binary Tree
//    + pathological/degenerate tree where the tree is dominated by left or right children
//    + there are two types, left and right skewed trees.

// Based on completion of levels
// 1. Complete Binary Tree
//    + Similar to a Full Binary Tree, with several major differences
//       - every level except the last level must be completely filled
//       - all leaf nodes must lean towards the left
//       - the last leaf node might not have a right sibling, meaning a Complete Binary Tree doesn't need to be a full binary tree. 

// 2. Perfect Binary Tree
//    + Where all internal nodes have two children and all leaf nodes are at the same level. 
//    + The number of leaf nodes is the number of internal nodes + 1
//    + A perfect binary tree of height h has 2 ^ (h+1) nodes
    
// 3. Balanced Binary Tree
//    + a binary tree is balanced if the height of the tree is O(Log n) where n is the number of nodes. 
//    + AVL trees maintain balance by making sure the difference of heights between the left and right subtrees is at most 1.
//    + Red / Black trees maintain balance by making sure that the number of Black nodes on every root to leaf paths is the same and that there are no adjacent red nodes.
//    + The main purpose of balancing a tree is that search / insertion / deletion all become O(Log n) time complexity.

// Based on Node Values
// 1. Binary search tree
//    + the left subtree of a node contains only nodes with keys lesser than the nodes key
//    + the right subtree of a node contains only nodes with keys greater than the nodes key
//    + the left and right subtree each must also be a binary search tree

// 2. AVL Tree
//    + A self balancing Binary Search Tree (BST) where the difference between heights of left and right subtrees cannot be more than one for all nodes.

// 3. Red Black Tree
//    + a self balancing BST where each node has an extra bit indicating a "color", either red or black. 
//    + The balance isn't perfect, but it keeps the time complexity around O(Log n), where n is the total number of elements. 

// 4. B Tree
//    + another self balancing data structure that allows efficient search/insertion/deletion. 
//    + Common in databases and file systems, able to efficiently store and retrieve large amounts of data. 
//    + Has a fixed maximum degree or order, this determines the max number of child nodes that a parent node can have. 
//    + Each node can have multiple child nodes and multiple keys, and the keys are used to index and locate data items. 

// 5. B+ Tree
//    + variation on the B tree, optimized for use in file systems and databases. 
//    + Has a fixed maximum degree. 
//    + Difference being, all data items are stored in the leaf nodes of the tree
//    + All internal nodes store keys that are an index for locating data items. 
 
// 6. Segment Tree / Statistic Tree
//    + used for storing information about intervals or segments. 
//    + Allows for querying which of the stored segments contain a given point. 
//    + It is in principle a static structure, meaning it can't be altered after creation. 
//    + similar to a Segment Tree. 
//    -- Don't really understand this yet.

// Chapter 0.1: Basic Operations 
// https://www.geeksforgeeks.org/introduction-to-binary-tree/

// Operations On Binary Tree
// 1: Traversal 
// Traversal involves visiting all the nodes of the binary tree. 
// Types of Traversal: 
//    - Depth First Search -- Explores as far down a branch as possible before backtracking, often uses recursion.
//       + Preorder traversal: current-left-right: visits the node, then left subtree, then right subtree
//       + Inorder traversal: left-current-right: visits the left subtree, the current node, then right subtree
//       + Postorder traversal: Visits the left subtree, then the right subtree, then the current node. 
//    - Breadth First Search -- explores all the nodes at the present depth before moving on to nodes at the next depth level. Often implemented useing a queue
//    commonly referred to as Level Order Traversal.
// 
// 2: Insertion to a Binary Tree
// Inserting into a Binary Tree involves adding a new node to the tree. 
// There is no such ordering of elements in a binary tree, we do not need to worry about the order of the nodes in the binary tree. 
// First create a root node in the case of an empty tree. Subsequent insertions involve iteratively searching for an empty place at each level of the tree. 
// When an empty left or right child is found the new node is inserted there. By convention, the left child is always inserted first.
//
// 3: Searching in a Binary Tree
// This involes looking through the tree to find a node that matches the given value.
// Since binary trees do not typically have a specific order, a traversal method is used here. 
// Most common methods involves BFS or DFS. Either method is repeated until we find the given node value or reach the end of the tree. 
// If the tree is empty or we search every node and don't find the value, then it's concluded the value doesn't exist in the tree. 
// 
// 4: Deletion in a Binary Tree
// Deleting a node in a binary tree means removing a specific node while keeping the tree structure intact. 
// Find the node that is to be deleted using a traversal method, or a search algorithm. 
// Replace the nodes value with the value of the last node in the tree, found by traversin to the right-most leaf.
// Delete the last node. This way, the tree structure won't be affected. 
// Check for special cases, like trying to delete from an empty tree 
//
// 5: Additional Operations
// - Finding the height of the Tree
// - Finding the level of a node in a binary tree
// - Find the size of the entire tree

// Chapter 0.2: Basics of Time Complexity
// In-Order Traversal -       Time - O(n) : Space - O(n)
// Pre-Order Traversal -      Time - O(n) : Space - O(n) 
// Post-Order Traversal -     Time - O(n) : Space - O(n) 
// Insertion (Unbalanced) -   Time - O(n) : Space - O(n)
// Searching (Unbalanced) -   Time - O(n) : Space - O(n)
// Deletion (Unbalanced) -    Time - O(n) : Space - O(n)
//
// Note: Space complexity can be reduced to O(1) with Morris Traversal
//

// -- Implementations

// basics of a node in a binary tree 
class BinaryTreeNode {
   constructor(data) {
      this.data = data;
      this.left = null;
      this.right = null;
   }
}

// Array implementation of a Binary Tree
// 1. Given an array that represents a tree in such a way that 
//    - array indexes are values in tree nodes
//    - array values are the parent value of that particular index
//    - the value of the root node will always be -1
// 2. Two ways to represent binary trees
//    - Dynamic Node representation
//    - Array representation
//







