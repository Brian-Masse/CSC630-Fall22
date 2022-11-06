// SORTING ALGORITHMS

// Limits of sorting Algorithms:

// Each sorting algorithm is given a sequence of n numbers, (a1, a2, a3,.., an) and returns a list of the same numbers in ascending or descending order
// Typically we sort a record, or structure of data, which has a series of keys and other, associated satellite data

// The keys are what is being sorted
// The Satellite data is associated and moved around with the keys
// If the satellite data is large, then instead we sort a list of pointers to avoid large data movement


// INSERTION SORT:

// operates in O(n^2)
// sorting in place: sorting the active array A, with only a constant number of elements from the input array are ever stored outside of the array

// starts with an unsorted list of data, and an empty return array.
// For each number in the collection, compare it to each of the elements in the array, until it is greater than the previous 
// The returning array will always be sorted

// Properties of Loop Invariants: 

// while iterating through the top loop, j:
    // A[0...j-i] represents all the elements that have already been sorted
    // A[0...j-i] are all formally members of A[j...n], but in a sorted algorithm
    // 
    // Must meet 3 criteria: (inductive reasoning for algorithm correctness)
        // 1. Initialization: It is true before the first iteration
        // 2. Maintenance: It is true before any given iteration, and remains true after that iteration 
        // 3. Termination: Provides a value to show that the algorithm is correct


// example:

func slice<T: Equatable>( _ array: [T], from int1: Int, to int2: Int) -> [T] { Array( array[int1...int2] ) }

var testRange = [ 99, 101, 1, 7, 22, 5, 54, 77, 21 ]

func insertionSort(_ array: inout [Float]) {

    for i in 0...array.count - 1 {

        var j = 0
        while array[i] > array[j] || j == array.count + 1 { j += 1 }

        let key = array[i]
        array.remove(at: i)
        array.insert(key, at: j)
    }
}

// insertionSort( &testRange )
// print(testRange)


// MERGE SORT:
// 
// Uses the divide and conquer technique: breaks the problem into similar sub problems, and then solving those problems via recursion:
    // Divide: the problem into smaller subproblems, that are small instances of the same problem
    // Conquer: the subproblems by solving them recursively 
    // Combine: the solutions to the subproblems into one solution for the main problem

// For the merge sort:  
    // Divide: Divide the sequence of n into 2 sequences of n/2
    // Conquer: Sort the two sequences recursively using merge sort
    // Merge the two sequences into one merged list
        // Merging completes in O(n)
        // where n = the length of the array to be sorted.



func mergeSort( _ array: [Int] ) -> [Int] {

    if array.count == 1 { return array }

    let halfLength = (array.count - 1) / 2
    let leftList = mergeSort( slice( array, from: 0, to: halfLength ) )
    let rightList = mergeSort( slice( array, from: halfLength + 1, to: array.count - 1 ) )

    
    return  merge( leftList, rightList )

    func merge( _ arr: [Int], _ arr2: [Int] ) -> [Int] {
        var returning: [Int] = []

        var i = 0
        var j = 0

        let arrCopy = arr + [Int.max]
        let arr2Copy = arr2 + [Int.max]

        for _ in 0...(arr.count + arr2.count - 1) {
            if arrCopy[i] <= arr2Copy[j] {
                returning.append( arrCopy[i] )
                i += 1
            }else {
                returning.append( arr2Copy[j] )
                j += 1
            }
        }
        return returning
    }
}

// print( mergeSort( testRange ) )


// HEAP SORT:

// combines the best parts of insertion and merge sorts:
// Operates in O(nlogn)
// Sorts in place

// HEAP:
// 
// Can be represented with a binary tree
// length - the length of the array that it represents
// size - the subselection the length that is actually relevant 

// Given an index of a node, we can find its children and parents
// Parent = A[i/2]
// Left = A[2i]
// Right = A[2i + 1]

// Max Heaps:
    // Depends on the max-heap-property:
    // for every node i other than the root
    // A[Parent(i)] ≥ A[i]

// Min Heaps:
    // Depends on the min-heap-property:
    // for every node i other than the root
    // A[parent(i)] ≤ A[i]

// Heap sort uses max heaps

// heap:

class Heap {

    private var underlyingList: [Int]
    var size: Int
    var root: Int {underlyingList[0]}

    init( _ array: [Int] ) {
        underlyingList = array
        size = underlyingList.count
        

        for i in 0...((size / 2) - 1){
            let f = ((size/2) - 1) - i
            maxHeap( f )
        }
    }

    func parent(_ i: Int) -> Int    { 
        var f = (Float(i) / 2)
        f.round(FloatingPointRoundingRule.down)
        return Int(f)
    }
    func left(_ i: Int) -> Int      { ((i + 1) * 2) - 1 }
    func right(_ i: Int) -> Int     { (i + 1) * 2 }

    func swap( _ index: Int, with index2: Int ) {
        let value = underlyingList[index]
        underlyingList[index] = underlyingList[index2]
        underlyingList[index2] = value
    }

    func maxHeap( _ i: Int ) {

        var largestIndex = i
        
        if left(i) <= size - 1 {
            if underlyingList[left(i)] > underlyingList[i] { largestIndex = left(i)}
        }
        if right(i) <= size - 1 {
            if underlyingList[right(i)] > underlyingList[largestIndex] { largestIndex = right(i)}
        }

        if largestIndex != i {
            let value = underlyingList[i]
            underlyingList[i] = underlyingList[largestIndex]
            underlyingList[largestIndex] = value
            maxHeap( largestIndex )
        }
    }

    func string() -> String {
        var returning = ""
        for i in 0...size - 1 { returning += "-> \(underlyingList[i]) " }
        return returning
    }
}

var test = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ]
var heap = Heap( test )

// print(heap.string())

// print( heap.parent( 0 ) )
// print( heap.right( 0 ) )
// print( heap.left( 0 ) )

// print(heap.string())
// heap.maxHeap( 0 )
// print(heap.string())

func heapSort( _ array: inout [Int] ) {

    let heap = Heap( array )

    for i in 0...array.count - 1 {
        array[array.count - 1 - i] = heap.root
        heap.swap( 0, with: heap.size - 1 )
        heap.size -= 1
        heap.maxHeap(0)
        
    }
}

// heapSort( &testRange )
// print(testRange)



// BUCKET SORT:

// runs in O(n) time
// requires that every element in the array is bound by [0, 1)

// Divides the interval [0, 1) into n sub-intervals (buckets)
// Puts each element of A into a corresponding bucket
// Sorts each of the buckets
// Lists each bucket, and all its elements in order to return the final bucket

// Example 

func BucketSort( _ array: [Float] ) -> [Float] {

    var buckets: [[Float]] = []
    var max = array.first!
    for item in array { 
        if item > max { max = item } 
        
        buckets.append( [] )
    }

    for item in array { 
        let value = item / (max + 1)
    
        var index = value * 10
        index.round(FloatingPointRoundingRule.down)

        buckets[ Int(index) ].append( value )
    }
    
    var returning: [Float] = []
    for i in 0..<buckets.count {
        if !buckets[i].isEmpty { 
            insertionSort( &buckets[i] )

            for f in 0..<buckets[i].count {
                buckets[i][f] *= (max + 1)
                returning.append( buckets[i][f] )
            }
        }
    }
    return returning
}

var floatTest: [Float] = [ 4, 1, 3, 2, 16, 9, 10, 14, 8, 7 ]
print( BucketSort( floatTest ) )
insertionSort( &floatTest )

print(floatTest)
