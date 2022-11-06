// QUICK SORT

// Worse case scenario  O(n^2)
// Average:             O (nlog(n)) (with low hidden constants)
// sorts in place

// DESCRIPTION
// Uses divide and conquer
// split the array into two arrays, centered around q [0...q-1] and [q+1...n]
// All elements in the first array should be less than A[q] and all the elements in the second array should be greater than A[q]
// Sort the two arrays using quicksort
// combine all arrays back together 

// EXAMPLE

var testRange = [ 7, 2, 4, 1, 22, 9, 12, 3 ]



func quickSort( _ array: [Int] ) -> [Int] {
    var arr = array

    if arr.isEmpty { return arr }

    let middleIndex = split(&arr)
    let leftSorted = quickSort( slice( arr, 0, middleIndex ) )
    let rightSorted = quickSort( slice( arr, middleIndex + 1, array.count ) )

    let returning = leftSorted + [ arr[middleIndex] ] + rightSorted
    return returning

    func slice( _ array: [Int], _ index1: Int, _ index2: Int ) -> [Int] {
        return Array( array[ index1..<index2 ] )
    }

    func split(  _ array: inout [Int] ) -> Int { 
        guard let last = array.last else { return 0 }

        var middle = 0
        
        for i in 0..<array.count - 1 {
            if array[i] < last {
                swap( &array, middle, i )
                middle += 1
            }
        }

        swap(&array, middle, array.count - 1)
        return middle
    }

    func swap( _ array: inout [Int], _ index1: Int, _ index2:Int ) {
        let stored = array[index1]
        array[index1] = array[index2]
        array[index2] = stored
    }
}

// print(quickSort(testRange))