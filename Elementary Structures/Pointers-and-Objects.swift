// POINTERS AND OBJECTS NOTES:

// you can build pointers and objects in langauges that do not support them using arrays and array indices

//here is an example object to represent
class testObject {
    let firstName: String
    let lastName : String
    let age: Int
    let favoriteColor: [String]

    var address: Int! 

    init( _ firstName: String, _ lastName: String, is age: Int, favoriteColors: [String] ) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.favoriteColor = favoriteColors
    }
}

// MULTI-ARRAY REPRESENTATION OF OBJECTS:
// if there are multiple objects, with a standard set of properties, you can represent them with a series of array 
// create x number of arrays, for the x number of properties
// at any given index i, store each property of the object in the various arrays

class testRepresentation {
    private var firstNames: [String] = []
    private var lastNames: [String] = []
    private var ages: [Int] = []
    private var favoriteColors: [ [String] ] = []

    // in the actual implementation you would not pass an object, but rather a set of parameters, im doing this because I'm lazy :)
    // in the actual implementation there would be a function / algorithm to find a free space of memory, in this case it just appends
    func insertObject( _ object: testObject ) {
        firstNames.append( object.firstName )
        lastNames.append( object.lastName )
        ages.append( object.age )
        favoriteColors.append( object.favoriteColor )
    }

    func string(address: Int) -> String {
        return "hello, my name is \(firstNames[address]) \(lastNames[address]), I am \(ages[address]) years old, and my favorite colors are: \(favoriteColors[address])"
    }
}

//test:

let testRepHeap = testRepresentation()

let Brian: testObject = testObject( "Brian", "Masse", is: 17, favoriteColors: ["pink", "blue", "orange"] )
let Tim: testObject = testObject( "Tim", "X", is: 3, favoriteColors: ["red"] )
let Yoda: testObject = testObject( "Yoda", "", is: 900, favoriteColors: ["green"] )

testRepHeap.insertObject(Brian)
testRepHeap.insertObject(Yoda)
testRepHeap.insertObject(Tim)

// print( testRepHeap.string(address: 0) )
// print( testRepHeap.string(address: 1) )


//SINGLE ARRAY REPRESENTATIONS

// in a single, very large list, store the properties of an object contiguously
// pass in a pointer for the first reference, and then provide an offset value for each subsequent property 
// the object will occupy A[j..k], meaning the pointer = j

//this flexible, and can store objects with different properties, and of different sizes in a single array

class testSingleRep {

    private var heap: [Any] = []

    func append( _ object: testObject ) {
        //there would probably be an algorithm to determine where to put this object, but in this case, I will simply append it
        //there would also need to be an object schema passed into this function, something like
            // testObject:
            //     firstName:      String      0
            //     lastName:       String      1
            //     age:            Int         2
            //     favoriteColors: [String]    3

        // so that the order of the properties is saved the same across all objects
        // this same schema would also be used in accessing / retrieving the data

        //in this example, because there is only one object type, I don't implement this

        heap.append( object.firstName )
        object.address = heap.count - 1

        heap.append( object.lastName )
        heap.append( object.age )
        heap.append( object.favoriteColor )
    }

    func string(address: Int) -> String {
        //should use object scheme to pull info from heap as described above

        return "hello, my name is \(heap[address]) \(heap[address + 1]), I am \(heap[address + 2]) years old, and my favorite colors are: \(heap[address + 3])"
        
    }
}

let singleRep = testSingleRep()

singleRep.append( Brian )
singleRep.append( Tim )
singleRep.append( Yoda )

// print(singleRep.string(address: Brian.address))
// print(singleRep.string(address: Yoda.address))



//ALLOCATING & FREEING MEMORY:

// in order to free objects from a multiple array representation, we must keep track of the unused objects 
// how objects are determined to be unused is up to a garbage collector, or in simple programs, can be stored in the objects themselves. 

// these free / unused spaces in memory are then held in a separate single linked list, which points to the next free space in memory
// a global variable keeps track of the head of this linked list, and moves there to allocate an object

// this free list acts like a stack, an object allocated is now the last one to be freed

    