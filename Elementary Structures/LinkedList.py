import string

class LinkedListNode:

    def __init__(self, data):
        self.data = data
        self.next = None 


class LinkedList:

    def __init__( self, startData ):

        #List initializer
        if isinstance(startData, list):

            self.head = LinkedListNode(startData[0])
            self.tail = LinkedListNode(startData[0])

            for i in range(1, len(startData)):
                nextNode = LinkedListNode( startData[i] )
                if i == 1: self.head.next = nextNode
                self.tail.next = nextNode
                self.tail = self.tail.next

        #Non list initializer
        else:
            self.head = LinkedListNode(startData)

    #Convenience Functions    
    def string(self):
        node = self.head
        string = ""

        while node != None:
            string += node.data
            node = node.next
            if node != None: string += " -> "

        return string
    
    def length(self):
        node = self.head
        length = 0

        while node != None:
            length += 1
            node = node.next

        return length

    #SEARCH FUNCTIONS:
    def findFirstMatch(self, data):
        node = self.head
        count = 0

        while node != None:
            if node.data == data: return (node, count)
            count += 1
            node = node.next

    def findAllMatches(self, data):
        node = self.head
        count = 0
        matches = []

        while node != None:
            if node.data == data: matches.append( (node, count) )
            count += 1
            node = node.next

        return matches

    def findNodeAt( self, index ):
        node = self.head
        count = 0 

        while node != None:
            if count == index: return node
            count += 1
            node = node.next
    
    #INSERT FUNCTIONS:
    def insert(self, index, value):
        node = self.findNodeAt(index)
        if node == None:
            print( "Index Out of Range" + index )
            return
        
        nextReference = node.next
        newNode = LinkedListNode( value )
        node.next = newNode
        newNode.next = nextReference

    def append( self, value ):
        nextNode = LinkedListNode( value )

        self.tail.next = nextNode
        self.tail = nextNode
    
    def prepend( self, value):
        newNode = LinkedListNode(value)
        newNode.next = self.head

        self.head = newNode

    #DELETE FUNCTIONS
    def delete(self, value):
        results = self.findFirstMatch(value)
        index = results[1]
        self.deleteAt(index)

    def deleteAt(self, index):
        if index == None: return
        node = self.findNodeAt(index)

        if index != 0:
            previousNode = self.findNodeAt( index - 1)
            previousNode.next = node.next
        
        else:
            self.head = node.next



# TESTING

# Creates a string representing the expected linkedList.string() function, given a list of strings
def constructStringOutputFrom(list):
    fullString = ""
    for i in range(0, len(list)):
        fullString += (list[i])
        if i != len(list) - 1:  fullString += " -> "
    return fullString
    

listObject = [ "first", "second", "third", "final" ]
linkedList = LinkedList( listObject )

# Checks that the expected ConstructStringOutputFrom and actual linkedList equal. If not, print an error
def testFunction( error ):
    result = linkedList.string()
    expectation = constructStringOutputFrom(listObject)

    if result != expectation:
        print( error + ": expected: (" + expectation + "), but got (" + result + ") instead.")

#check length 
if linkedList.length() != 4: print( "length is incorrect" )

newFinal = "newFinal"
newHead = "newHead"
newSecond = "newSecond"

#check Insert Functions
listObject.insert(0, newHead)
linkedList.prepend(newHead)
testFunction("error in prepend")

listObject.insert(3, newSecond)
linkedList.insert(2, newSecond)
testFunction("error in insert(at:)")

listObject.append(newFinal)
linkedList.append(newFinal)
testFunction("error in append")

# Check Delete Function
listObject.remove( newFinal )
linkedList.delete( newFinal )
testFunction("error in delete(value:)")

listObject.remove( newSecond )
linkedList.deleteAt( 3 )
testFunction("error in deleteAt()")







