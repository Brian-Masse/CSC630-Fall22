// Linked List:

class Node<T: Equatable> {

    var data: T
    var next: Node? = nil
    var prev: Node? = nil

    init( _ data: T ) {
        self.data = data
    }

}


class LinkedList<T: Equatable> {

    var head: Node<T>!
    var tail: Node<T>!

    init( _ list: [T] ) {

        guard let first = list.first else { return }
        let newNode = Node(first) 

        self.head = newNode
        self.tail = newNode

        for i in 1...list.count - 1{
            let newNode = Node(list[i])
            self.tail.next = newNode
            let prev = self.tail
            self.tail = newNode
            newNode.prev = prev
        }
    }

    private func iterate( _ function: (Node<T>) -> Void, _ breakCondition: (Node<T>) -> Bool = {_ in false}) {
        var node = self.head

        while node != nil {
            function( node! )
            if breakCondition(node!) { return }

            node = node!.next            
        }
    }

    func string() -> String {
        var string: String = ""

        iterate() { node in string += "-> \(node.data) " }

        return string
    }

    func length() -> Int {
        var count: Int = 0
        iterate { _ in count += 1 }
        return count
    }

    func search( _ data: T ) -> Node<T>? {
        var returning: Node<T>? = nil

        iterate( { node in if node.data == data { returning = node } } ) { node in node.data == data }
        if returning == nil { print("cant find node") }
        return returning
    }

    func append( _ data: T ) {
        let newNode = Node(data)
        self.tail.next = newNode
        self.tail = newNode
    }

    func insert( _ data: T, at index: Int ) {
        if index >= self.length() { print("out of bounds"); return }

        var i: Int = -1
        var node: Node<T>!

        iterate({ n in i += 1; node = n }) { _ in i == index }

        let newNode = Node(data)
        let prev = node.prev
        node.prev = newNode

        if let prev = prev { prev.next = newNode } 
        newNode.prev = prev
        newNode.next = node

        if i == 0 { self.head = newNode }
    }

    func delete( _ data: T) {

        var node: Node<T>!
        iterate( {n in node = n} ) { n in n.data == data }

        if node.data != data { print("did not find data"); return  }

        if let prev = node.prev { prev.next = node.next }
        if let next = node.next { next.prev = node.prev }

    }

} 

let dummyData = ["A", "B", "C", "D", "E"]
let linkedList = LinkedList( dummyData )

func getProperties() {
    print( linkedList.string() )
    print( linkedList.length() )
}

// if let node = linkedList.search("F") { print( node.data ) }

// linkedList.append("F")
// getProperties()

// linkedList.insert( "D.5", at: 4) 
// linkedList.append( "E.5") 
// linkedList.delete( "D5") 
// getProperties()



class Stack<T: Equatable> {

    private var underlyingArray: [T]

    init( _ list: [T] ) {
        underlyingArray = list
    }

    func push(_ data: T) {
        underlyingArray.append( data )
    }

    func pop() {
        underlyingArray.removeLast()
    }

    func string() -> String {
        var string: String = ""
        for node in underlyingArray {
            string += "-> \(node) "
        }
        return string
    }
}

let stack = Stack(dummyData)

// print(stack.string())
// stack.pop()
// stack.pop()
// print(stack.string())

// stack.push( "F" )
// stack.push( "F.5" )
// print(stack.string())

// stack.pop()
// print(stack.string())

class Queue<T: Equatable> {

    private var underlyingArray: [T] = []

    init( _ list: [T] ) {
        underlyingArray = list
    }

    func push(_ data: T) {
        underlyingArray.append(data)
    }

    func pop() {
        underlyingArray.remove(at: 0)
    }

    func string() -> String {
        var string: String = ""
        for node in underlyingArray {
            string += "-> \(node) "
        }
        return string
    }
}

let queue = Queue(dummyData)
print(queue.string())

queue.push( "E.5" )
queue.pop()
print(queue.string())

