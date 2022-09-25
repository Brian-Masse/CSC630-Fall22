// MARK: Notes

// QUEUES 
// a collection of data where the access patterns are predetermined
// 
// items are accessed / removed from the bottom of the queue, first in first out (FIFO)

class Queue<T: Hashable> {

    let limit: Int

    var head: Int = 0
    var tail: Int = 0

    private var underlyingArray: [T?] = []
    
    private func constructArray() {
        underlyingArray = []
        for _ in 0...limit {
            underlyingArray.append( nil )
        }
    }

    //accounts for the wrapping queue 
    private func decrementIndex(_ int: Int) -> Int {
        var returning = int
        returning -= 1
        if returning < 0 { returning = limit - 1}
        return returning
    }

    private func incrementIndex(_ int: Int) -> Int {
        var returning = int
        returning += 1
        if returning > limit - 1 { returning = 0}
        return returning
    }

    init(limit: Int) {
        self.limit = limit
        self.constructArray()
    }

    init(withSeries series: [T], limit: Int) {
        self.limit = limit
        self.constructArray()
        for data in series {
            self.enqueue(data)
        }
    }

    //adds an element at the tail of the queue
    func enqueue(_ data: T) {
        if tail == head - 1 { print("ERROR: [Enqueuing] Queue Overflow "); return }
        underlyingArray[ tail ] = data
        self.tail = self.incrementIndex(self.tail)
    }

    func enqueue(items: [T]) {
        for item in items {
            self.enqueue( item )
        }
    }

    //removes data from the tail of the queue 
    func dequeue() -> T? {
        if tail == head { print("ERROR: [Dequeuing] Queue Underflow "); return nil }
        let returning =  underlyingArray[ head ]
        underlyingArray[head] = nil
        self.head = self.incrementIndex(self.head)
        return returning
    }

    // returns the queue in a string format
    func string() -> String {
        var string = ""
        var index: Int = self.decrementIndex(self.tail)

        while index != self.decrementIndex(head) {
            string += "(\(underlyingArray[index]!), \(index)"
            if index == head { string += ", head" }
            if index == self.decrementIndex(tail) { string += ", tail" }
            string += "), "

            index = self.decrementIndex(index)
        }
        return string
    }

    func strippedString () -> String {
        var string = ""
        var index: Int = self.decrementIndex(self.tail)

        while index != self.decrementIndex(head) {
            string += "\(underlyingArray[index]!), "

            index = self.decrementIndex(index)
        }
        return string
    }
}

// MARK: Testing Queue

let items = [ "item1", "item2", "item3", "item4" ]
let queue = Queue(withSeries: items, limit: 6) 

if queue.strippedString() != "item4, item3, item2, item1, " { print("ERROR: [initialization] does not match expected result") }

let _ = queue.dequeue()
if queue.strippedString() != "item4, item3, item2, " { print("ERROR: [Dequeue] does note match expected result") }

queue.enqueue( items: ["new item1", "new item2"] )
if queue.strippedString() != "new item2, new item1, item4, item3, item2, " { print("ERROR: [Enqueue] does not match expected result") }
