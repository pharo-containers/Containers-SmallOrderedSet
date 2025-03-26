Class {
	#name : 'CTSmallOrderedSetTest',
	#superclass : 'TestCase',
	#instVars : [
		'collection'
	],
	#category : 'Containers-SmallOrderedSet',
	#package : 'Containers-SmallOrderedSet'
}

{ #category : 'configuration' }
CTSmallOrderedSetTest >> collectionClass [
	^ CTSmallOrderedSet
]

{ #category : 'running' }
CTSmallOrderedSetTest >> setUp [
	super setUp.
	collection := CTSmallOrderedSet new
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testAdd [
	| object |
	object := Object new.
	self assert: collection size equals: 0.
	self assert: (collection add: object) equals: object.
	self assert: collection size equals: 1.
	self assert: (collection add: object) equals: object
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testAddAll [
	collection addAll: #(2 1 1).
	self assert: collection size equals: 2.
	self assert: (collection includes: 1).
	self assert: (collection includes: 2)
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testAddAllKeepsOrder [
	collection addAll: #(2 1 1 3 4 5 5 5 6).
	self assert: collection size equals: 6.
	self assert: collection asArray equals: #(2 1 3 4 5 6).
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testAsArray [
	collection addAll: #(2 1 1).
	self assert: collection asArray equals: #(2 1).
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testAsArrayWithStrangeOrder [
	collection addAll: #(2 1 3 2 1).
	self assert: collection asArray equals: #(2 1 3).
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testCopy [
	| copy |
	collection add: 1.
	copy := collection copy.
	collection add: 2.
	
	self assert: collection size equals: 2.
	self assert: copy size equals: 1.
	
	self assert: (collection includes: 2).
	self deny: (copy includes: 2).
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testDo [
	| seen |
	collection addAll: #(2 1 1).
	seen := Array streamContents: [ :stream |
		collection do: [ :each |
			stream nextPut: each ] ].
	self assert: seen size equals: 2.
	self assert: (seen at: 1) equals: 2.
	self assert: (seen at: 2) equals: 1
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testDoSeparatedBy [
    | seen |

    "Add elements manually, including duplicates"
    collection add: 2.
    collection add: 1.
    collection add: 3.
    collection add: 2.  "Duplicate"
    collection add: 1.  "Duplicate"

    "Verify that collection size is correct (duplicates should not be counted)"
    self assert: collection size equals: 3.

    "Iterate over the collection, inserting separators"
    seen := Array streamContents: [ :stream |
        collection do: [ :each | stream nextPut: each ] 
                  separatedBy: [ stream nextPut: '-' ] ].

    "Ensure separators are added correctly and duplicates are not present"
    self assert: seen equals: #(2 '-' 1 '-' 3).
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testGrow [ 
    | initialCapacity elementsBeforeGrow elementsAfterGrow expectedSize |

    "Create a small set with a fixed capacity"
    collection := CTSmallOrderedSet new: 2.  "Initial capacity = 2"
    initialCapacity := collection size.

    "Add elements up to the initial limit"
    collection add: 1.
    collection add: 2.

    "Store elements before triggering `grow`"
    elementsBeforeGrow := collection asArray.

    "Add one more element to force `grow`"
    collection add: 3.

    "Store elements after `grow`"
    elementsAfterGrow := collection asArray.

    "Calculate expected size (since we added 3 elements)"
    expectedSize := 3.

    "Assert that the collection size increased"
    self assert: (collection size > initialCapacity).

    "Assert that the collection size is exactly what we expect"
    self assert: collection size equals: expectedSize.

    "Verify all original elements are still in order"
    self assert: (elementsAfterGrow copyFrom: 1 to: elementsBeforeGrow size) equals: elementsBeforeGrow.

    "Ensure the newly added element exists"
    self assert: (collection includes: 3).

]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testIncludes [
	self deny: (collection includes: 0).
	collection add: 0.
	self assert: (collection includes: 0)
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testIsEmpty [
	self assert: collection isEmpty.
	collection add: 1.
	self deny: collection isEmpty.
	collection remove: 1.
	self assert: collection isEmpty
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testRemove [
	collection add: 1.
	self assert: (collection remove: 1) equals: 1.
	self should: [ collection remove: 1 ] raise: Error
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testRemoveIfAbsent [
	| absent |
	collection add: 1.
	absent := false.
	
	self assert: (collection remove: 1 ifAbsent: [ absent := true ]) equals: 1.
	self deny: absent.
	
	collection remove: 1 ifAbsent: [ absent := true ].
	self assert: absent.
]

{ #category : 'testing' }
CTSmallOrderedSetTest >> testSize [
	self assert: collection size equals: 0.
	collection addAll: #(2 1 1).
	self assert: collection size equals: 2.
]
