
// ROOTED AND ORDERED TREES:

// A free tree where 1 vertex is distinguished from the other. 
// The distinguished node is called the Node
// All the other vertexes are nodes


//Consider the tree with x nodes, and Node r:
// 
// On the unique and simple path between r and x, and node y is called the ancestor
// this means that x is a descendent of any of these y
// x and y are both descendent's and ancestor's of themselves
// 
// if y is an ancestor of x, and x != y, then y is a proper ancestor, and x is a proper descendent 
//
// if there is no separation between (y, x) then y is a parent of x, and x is a child of y
// All nodes have parents except the Node
// nodes with the same parent are siblings
// nodes with no children are leaf nodes or external nodes
// nodes with children are internal nodes
// the number of children a node x has is its degree
// 
// The depth of x = The length of the simple path from Node r to x
// The height of x = The longest simple downwards path from x to a leaf node
// The height of the tree = the height of r or the biggest depth of any node
// 
// An ordered rooted tree is one where the children of a node are ordered

//helper functions
func getMemoryAdress<T: AnyObject>(of object: T) -> String { "\(Unmanaged.passRetained( object ).toOpaque())" }

func pow(_ int1: Int, _ int2: Int) -> Int {
    if int2 == 0 { return 1 }
    var returning = int1
    for _ in 1..<max(int2, 1) {
        returning *= int1
    }
    return returning
}

// Modeled After a Binary Tree
class RootedTree<T: Hashable> where T: Comparable {

    let fill = "." // the character used for empty space in the render of the tree

    var root: Node<T>!

    init( _ rootData: T ) {
        root = Node( rootData )
    }

    // Convenience functions
    func createNode(with data: T) -> Node<T> {
        return Node( data )
    }

    func string() -> String {
        return root.string()
    }

    func formattedString() -> String {
        let height = self.height(of: self.root)
        let width = pow(2, (height + 1))
        
        //create the multi-dimensional array
        var screen: [ [ T? ] ] = []
        
        var secondaryArray: [T?] = []
        for _ in 0...(width) { secondaryArray.append(nil) }
        for _ in 0...(height) { screen.append(secondaryArray) }

        //begins creating a grid representation of the binary tree
        root.renderString(array: &screen, x: (width / 2), y: 0)

        //create the rendering string
        var visual = ""
        for y in screen {

            for data in y {
                if data == nil { visual += (fill + fill + fill) }  
                else { visual += "[\(data!)]" }
            }
            visual += "\n"
        }

        return visual
    }

    // Insert Functions
    func insert( _ data: T) {
        let newNode = Node(data)
        root.insert( newNode )
    }

    func insert( newNode: Node<T> ) {
        root.insert( newNode )
    }

    func insert( series: [T] ) {
        for data in series {
            self.insert( data )
        }
    }


    func find(_ data: T) -> Int { 
        return root.find( 0, data: data )
    }

    //Information Properties 
    func depth( of node: Node<T> ) -> Int {
        return self.find(node.data)
    }

    func height(of node: Node<T> ) -> Int {
        return node.deepestBranch()
    }

    class Node<T: Hashable>: Equatable, Comparable where T: Comparable {

        var leftNode: Node? = nil
        var rightNode: Node? = nil

        let data: T

        var leafNode: Bool { self.leftNode == nil && self.rightNode == nil }

        init( _ data: T ) {
            self.data = data
        }

    func insert( _ newNode: Node ) {
        if newNode == self || newNode > self { 
            if rightNode == nil { self.rightNode = newNode } 
            else { self.rightNode!.insert(newNode) }
        }

        if newNode < self { 
            if leftNode == nil { self.leftNode = newNode } 
            else { self.leftNode!.insert(newNode) }
        }
    }

    func find(_ int: Int, data: T) -> Int {
        if self.leafNode || self.data == data { return int } 
        let newInt = int + 1
        if data > self.data { return self.rightNode!.find(newInt, data: data) }
        if data < self.data { return self.leftNode!.find(newInt, data: data) }
        return newInt
    }
    
    func deepestBranch() -> Int {
        if self.leafNode { return 0 }
        let rightLength = self.rightNode == nil ? 0 : self.rightNode!.deepestBranch()
        let leftLength = self.leftNode == nil ? 0 : self.leftNode!.deepestBranch()

        return 1 + max(rightLength, leftLength)
    }

    //Information Functions
    func string() -> String {
        
        if self.leafNode { return "[\(self.data)]" } 

        let left = self.leftNode == nil ? "nil" : self.leftNode!.string()
        let right = self.rightNode == nil ? "nil" : self.rightNode!.string()

        let string =  "([\(self.data)] -> (\(left), \(right))" 
        return string
    }

    func renderString(array: inout [[T?]], x: Int, y: Int ) {
        array[ y ][ x ] = self.data

        // Depending on what layer the node is, it is given a different shift away from its parent
        let shift = max(pow(2, (self.deepestBranch() - 1)), 0)
        
        if let leftNode = self.leftNode { leftNode.renderString( array: &array, x: x - shift, y: y + 1 ) }
        if let rightNode = self.rightNode { rightNode.renderString( array: &array, x: x + shift, y: y + 1 ) }

    }

    //COMPARABLE FUNCTIONS
        static func == (lhs: Node, rhs: Node) -> Bool {
            lhs.data == rhs.data
        }

        public static func < (lhs: Node, rhs: Node) -> Bool {
            lhs.data < rhs.data
        }

        public static func > (lhs: Node, rhs: Node) -> Bool {
            lhs.data > rhs.data
        }

        func equals( rhs: Node ) -> Bool {
            getMemoryAdress(of: self) == getMemoryAdress(of: rhs)
        }
    }
}

//initializing it with a root
let rootedTree = RootedTree( 5 )

//inserting dummy data
let testNumbers = [ 8, 8, 5, 7, 6, 9, 1, 0, 2 ]
rootedTree.insert(series: testNumbers)

//creating a node to reference
let newNode = rootedTree.createNode( with: 2 )
rootedTree.insert( newNode: newNode )

print( rootedTree.string() )
print( rootedTree.formattedString())