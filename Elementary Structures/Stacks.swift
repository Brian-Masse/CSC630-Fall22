// MARK: Notes

// STACKS 
// a collection of data where the access patterns are predetermined
// 
// items are accessed / removed from the top of the stack, last in first out (LIFO)


// MARK: Stack
class Stack<T: Hashable> {

    var top: Int = 0 
    let limit: Int!     //when this is not -1, it represents the max data allowed in the stack

    private var underlyingArray: [StackElement<T>] = [] {
        didSet { self.updateTop() } 
    }

    private func updateTop() {
        top = max(underlyingArray.count - 1, 0)
        if limit != -1 { top = min( top, limit ) }
    }

    //initializes with a single piece of data
    init( with data: T, limit: Int = -1 ) {
        underlyingArray.append( StackElement( data ) )
        self.limit = limit
        self.updateTop()
    }

    //initializes with a series of data
    init( withSeries dataSeries: [T], limit: Int = -1 ) {
        self.limit = limit
        if dataSeries.isEmpty { return }

        for data in dataSeries {
            underlyingArray.append( StackElement( data ) )
        }
        self.updateTop()
    }
    
    func push( _ data: T ) {
        if limit != -1 && (top + 1 == limit) { print( "Error: stack limit reached"); return }

        self.underlyingArray.append( StackElement(data) )
    }

    func pop() {
        if limit != -1 && (top == limit) { print( "Error: Stack Overflow"); return }

        if self.isEmpty() { print( "Error: Stack Underflow" ); return }
        underlyingArray.remove(at: self.top)
    }


    //returns a string representation of the stack
    func string() -> String {
        var string = ""
        for element in underlyingArray {
            string += "\(element.data), "
        }
        return string
    }

    func isEmpty() -> Bool {
        return top == 0
    }

    class StackElement<T: Hashable> {
        let data: T

        init( _ data: T ) {
            self.data = data
        }
    }
}

//MARK: Stack Testing

let stackItems = [ "test1", "test2", "test3" ]
let stack = Stack( withSeries: stackItems )

if stack.string() != "test1, test2, test3, " { print( "error in the series initialization" ) } 
if stack.top != 2 { print("Top not in sync with data") }

stack.push( "test4" )
if stack.string() != "test1, test2, test3, test4, " { print( "error when pushing to the stack" ) } 
if stack.top != 3 { print("Top not in sync with data") }

stack.pop()
if stack.string() != "test1, test2, test3, " { print( "error when popping" ) } 
if stack.top != 2 { print("Top not in sync with data") }

let limitedStack = Stack(withSeries: stackItems, limit: 3) 

limitedStack.push("test4") // should cause an error
limitedStack.pop() // should not cause an error
if limitedStack.string() != "test1, test2, " { print("error when popping on a limitedStack") }


//MARK: Queues


