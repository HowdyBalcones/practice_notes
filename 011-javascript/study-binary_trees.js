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

// basics elements of a node in a binary tree 
class BinaryTreeNode {
   constructor(data) {
      this.data = data;
      this.left = null;
      this.right = null;
   }
}

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
//
// Disadvantages: 
// Limited Structure - since a node can only have at most two children, a different tree structure might need to be used
// Unbalanced Trees - when a subtree is significantly larger than the other, it can lead to inefficient search operations.
//                    This can occur when the tree is not properly balanced or data is inserted in a non-random order.
// Space Efficiency - Can be space inefficient because each node requires two child references or pointers, this can be a significant overhead for large trees.
// Slow in worst cases - a Binary Tree can become degenerate or skewed, meaning that each node has only one child. In this case, search operations in 
//                       a Binary Search Tree (variation of binary tree) can degrade to O(n) time complexity, where n is the nubmer of nodes in the tree. 

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
// 2. Degenerate Binary Tree
// 3. Skewed Binary Tree
//
// Based on completion of levels
// 1. Complete Binary Tree
// 2. Perfect Binary Tree
// 3. Balanced Binary Tree
//
// Based on Node Values
// 1. Binary search tree
// 2. AVL Tree
// 3. Red Black Tree
// 4. B Tree
// 5. B+ Tree
// 6. Segment Tree

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




