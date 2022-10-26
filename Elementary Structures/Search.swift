// The following search algorithms are specifically for graphs, and all have a time complexity of O(V + E)

// graphs of algorithms involve a collection of vertices and edges G[V, E]


// BREADTH FIRST SEARCH
// the breadth first search implies moving through a graph's width first; it will go through each node at a specific level before moving down a level

//while moving through this algorithm, keep track of the nodes that have been visited, and the nodes that have to visited
// The nodes that must be visited can be marked with a Queue structure with a FIFO access pattern

// the general pattern of the algorithm follows:

// - starting at the root:
//     - pop the oldest object in th queue
//     - mark that node as visited
//     - insert all of that objects nodes into the queue

// by doing this, every node at a given level will be visited before searching the next level

// DEPTH FIRST SEARCH
// the depth first search implies moving through a graph's height first; it will go through every child of a node before moving to the sibling of that node

// mirrors the depth first search in function, timing, and implementation, except this uses a stack instead of a queue, with a LIFO access pattern


// TOPOLOGICAL SORT
// returns a graph sorted such that the any node is above each of its children. 
// This works nearly identically to the depth first searchL

// - starting at the root:
//     - check to see if the node has any neighbors, already marked 
//     - if it doesn't, add it to the stack
//     - if it does, repeat the process for those nodes


//example 

//simple tree
class Node {
    let name: String
    var children: [Node]
    var visited: Bool = false

    init( _ name: String, _ children: [Node] = [] ) {
        self.name = name
        self.children = children
    }

    func topologicalSort(_ string: inout String)  {
        if self.children.isEmpty { string += "-> \(self.name) "; return }
        else {
            for child in children { child.topologicalSort(&string) }
            string += "-> \(self.name) "
            return
        }
    }
}

class Tree {

    let root: Node

    init(_ root: Node) {
        self.root = root
    }

    // for testing this prints an array showing the access patterns
    // it will be moving from left to right for each row before moving down
    func breadthFirstSearch( name: String ) ->  String {
        var string: String = ""

        var queue: [ Node ] = []
        queue.append( root )

        while !queue.isEmpty {
            let head = queue.first!
            queue.removeFirst()

            // for the actual search
            // if head.name == name { return head }

            for child in head.children { queue.append(child) }
            string += "-> \(head.name) "
        
        }
        return string
    } 

    // for testing this prints an array showing the access patterns
    // it will be moving from top to bottom before moving right 
    func depthFirstSearch( name: String ) ->  String {
        var string: String = ""

        var stack: [ Node ] = []
        stack.append( root )

        while !stack.isEmpty {
            let head = stack.last!
            stack.removeLast()

            // for the actual search
            // if head.name == name { return head }

            for child in head.children { stack.append(child) }
            string += "-> \(head.name) "
        
        }
        return string
    }   

    func topologicalSort2() -> String {
        var string: String = ""

        root.topologicalSort(&string)

        return string
    }

    func topologicalSort() -> String {

        // in this case, the string acts as the topological stack (reversed). The stack variable is a private stack used to facilitate the motion of this algorithm
        var string: String = ""
        var stack: [Node] = []
        stack.append( root )

        while !stack.isEmpty {
            let head = stack.last!
            head.visited = true

            if head.children.allSatisfy({ $0.visited }) { 
                string.append( "-> \(head.name) " ) 
                stack.removeLast()
            }else {
                for child in head.children { stack.append(child) }
            }
        }

        return string
    }
}


//terrible way to initialize a tree :0
let I = Node("I")
let H = Node("H")
let G = Node("G", [I])
let F = Node("F", [H])
let E = Node("E")
let D = Node("D")
let C = Node("C", [G])
let B = Node("B", [D, E, F])
let A = Node("A", [B, C])

let tree = Tree( A )

// testing: 
// print(tree.breadthFirstSearch(name: "E"))
// print(tree.depthFirstSearch(name: "E"))
// print(tree.topologicalSort())
// print(tree.topologicalSort2() )





