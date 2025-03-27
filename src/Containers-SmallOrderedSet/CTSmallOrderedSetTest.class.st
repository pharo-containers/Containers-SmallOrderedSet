Class {
	#name : #CTSmallOrderedSetTest,
	#superclass : #TestCase,
	#instVars : [
		'collection'
	],
	#category : #'Containers-SmallOrderedSet'
}

{ #category : #configuration }
CTSmallOrderedSetTest >> collectionClass [
	^ CTSmallOrderedSet
]

{ #category : #running }
CTSmallOrderedSetTest >> setUp [
	super setUp.
	collection := CTSmallOrderedSet new
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAdd [
	| object |
	object := Object new.
	self assert: collection size equals: 0.
	self assert: (collection add: object) equals: object.
	self assert: collection size equals: 1.
	self assert: (collection add: object) equals: object
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAddAll [
	collection addAll: #(2 1 1).
	self assert: collection size equals: 2.
	self assert: (collection includes: 1).
	self assert: (collection includes: 2)
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAddAllKeepsOrder [
	collection addAll: #(2 1 1 3 4 5 5 5 6).
	self assert: collection size equals: 6.
	self assert: collection asArray equals: #(2 1 3 4 5 6).
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAsArray [
	collection addAll: #(2 1 1).
	self assert: collection asArray equals: #(2 1).
]

{ #category : #testing }
CTSmallOrderedSetTest >> testAsArrayWithStrangeOrder [
	collection addAll: #(2 1 3 2 1).
	self assert: collection asArray equals: #(2 1 3).
]

{ #category : #testing }
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

{ #category : #testing }
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

{ #category : #testing }
CTSmallOrderedSetTest >> testIncludes [
	self deny: (collection includes: 0).
	collection add: 0.
	self assert: (collection includes: 0)
]

{ #category : #testing }
CTSmallOrderedSetTest >> testIsEmpty [
	self assert: collection isEmpty.
	collection add: 1.
	self deny: collection isEmpty.
	collection remove: 1.
	self assert: collection isEmpty
]

{ #category : #testing }
CTSmallOrderedSetTest >> testRemove [
	collection add: 1.
	self assert: (collection remove: 1) equals: 1.
	self should: [ collection remove: 1 ] raise: Error
]

{ #category : #testing }
CTSmallOrderedSetTest >> testRemoveIfAbsent [
	| absent |
	collection add: 1.
	absent := false.
	
	self assert: (collection remove: 1 ifAbsent: [ absent := true ]) equals: 1.
	self deny: absent.
	
	collection remove: 1 ifAbsent: [ absent := true ].
	self assert: absent.
]

{ #category : #testing }
CTSmallOrderedSetTest >> testSize [
	self assert: collection size equals: 0.
	collection addAll: #(2 1 1).
	self assert: collection size equals: 2.
]

{ #category : #testing }
CTSmallOrderedSetTest >> testWithAll [
    | emptySet singleSet duplicateSet orderedSet mixedSet largeSet unorderedSet specialCharSet expected |

    "Empty Collection Input"
    emptySet := CTSmallOrderedSet withAll: #().
    self assert: emptySet isEmpty.

    "Single Element Collection"
    singleSet := CTSmallOrderedSet withAll: #(42). 
    self assert: singleSet size equals: 1.
    self assert: (singleSet includes: 42).

    "Collection With Only Duplicates"
    duplicateSet := CTSmallOrderedSet withAll: #(7 7 7 7 7).
    self assert: duplicateSet size equals: 1.
    self assert: (duplicateSet includes: 7).

    "Already Ordered Input"
    orderedSet := CTSmallOrderedSet withAll: #(10 20 30).
    expected := #(10 20 30).
    self assert: orderedSet asArray equals: expected.

    "Mixed Data Types"
    mixedSet := CTSmallOrderedSet withAll: #(1 'a' 2 'b' 1 'a').
    self assert: mixedSet size equals: 4.
    self assert: (mixedSet includes: 1).
    self assert: (mixedSet includes: 'a').
    self assert: (mixedSet includes: 2).
    self assert: (mixedSet includes: 'b').

    "Large Input Collection"
    largeSet := CTSmallOrderedSet withAll: (1 to: 10000).
    self assert: largeSet size equals: 10000.

    "Unordered Input"
    unorderedSet := CTSmallOrderedSet withAll: #(5 2 8 1 3).
    self assert: unorderedSet asArray equals: #(5 2 8 1 3).

    "Collection With Special Characters"
    specialCharSet := CTSmallOrderedSet withAll: #('hello' 'world' 'hello!' 'world#').
    self assert: specialCharSet size equals: 4.
    self assert: (specialCharSet includes: 'hello!').
    self assert: (specialCharSet includes: 'world#').

]

{ #category : #testing }
CTSmallOrderedSetTest >> testRemoveIndex [

	| collectionSet |
	"Create a set and add some elements"
	collectionSet := CTSmallOrderedSet new: 5.
	collectionSet add: 1.
	collectionSet add: 2.
	collectionSet add: 3.
	collectionSet add: 4.

	"Remove an element by index"
	collectionSet removeIndex: 2.

	
	"Test that the collection size decreased"
	self assert: collectionSet size equals: 3.
	self assert: (collectionSet asArray) equals: #( 1 3 4 ).
	"Test that the removed element is no longer in the collection"
	self deny: (collectionSet includes: 2).

	"Test removing from an empty set"
	collectionSet := CTSmallOrderedSet new: 0.
	self should: [ collectionSet removeIndex: 1 ] raise: Error.

	"Test removing from an empty set with error message"
	collectionSet := CTSmallOrderedSet new: 0.
	

	"Test removing the first index"
	collectionSet := CTSmallOrderedSet new: 3.
	collectionSet add: 1.
	collectionSet add: 2.
	collectionSet add: 3.
	collectionSet removeIndex: 1.
	self assert: collectionSet size equals: 2.
	self assert: (collectionSet asArray) equals: #( 2 3 ).

	"Test removing the last index"
	collectionSet := CTSmallOrderedSet new: 3.
	collectionSet add: 1.
	collectionSet add: 2.
	collectionSet add: 3.
	collectionSet removeIndex: 3.
	self assert: collectionSet size equals: 2.
	self assert: (collectionSet asArray) equals: #( 1 2 ).

	"Test removing an index out of bounds"
	collectionSet := CTSmallOrderedSet new: 3.
	collectionSet add: 1.
	collectionSet add: 2.
	collectionSet add: 3.
	self should: [ collectionSet removeIndex: 4 ] raise: Error.

	"Test removing the only element in the set"
	collectionSet := CTSmallOrderedSet new: 1.
	collectionSet add: 1.
	collectionSet removeIndex: 1.
	self assert: collectionSet isEmpty.
	self assert: collectionSet size equals: 0
]

{ #category : #testing }
CTSmallOrderedSetTest >> testGrow [
    | initialCapacity elementsBeforeGrow elementsAfterGrow expectedSize sizeAfterDuplicates zeroCapacitySet |

    "Create a small set with a fixed capacity"
    collection := CTSmallOrderedSet new: 2.  "Initial capacity = 2"
    initialCapacity := 2.
    "Add elements up to the initial limit"
    collection add: 1.
    collection add: 2.

    "Store elements before triggering grow"
    elementsBeforeGrow := collection asArray.

    "Ensure that collection reached its initial capacity"
    self assert: collection size equals: initialCapacity.

    "Add one more element to force growth"
    collection add: 3.

    "Store elements after growth"
    elementsAfterGrow := collection asArray.

    "Calculate expected size (since we added 3 unique elements)"
    expectedSize := 3.

    "Assert that the collection size increased"
    self assert: (collection size > initialCapacity).

    "Assert that the collection size is exactly what we expect"
    self assert: collection size equals: expectedSize.

    "Verify all original elements are still in order"
    self assert: (elementsAfterGrow copyFrom: 1 to: elementsBeforeGrow size) equals: elementsBeforeGrow.

    "Ensure the newly added element exists"
    self assert: (collection includes: 3).

    "Store size before attempting to add duplicates"
    sizeAfterDuplicates := collection size.

    "Try adding duplicates"
    collection add: 2.  "Duplicate"
    collection add: 1.  "Duplicate"
    collection add: 3.  "Duplicate"

    "Assert that size does not increase when adding duplicates"
    self assert: collection size equals: sizeAfterDuplicates.

    "Ensure that duplicates were not added and order remains unchanged"
    self assert: (collection asArray) equals: #(1 2 3).

    "Edge Case: Force another growth by adding new elements"
    collection add: 4.
    collection add: 5.
    collection add: 6.  "Should trigger another growth"

    "Verify the collection still maintains order after multiple growths"
    self assert: (collection asArray) equals: #(1 2 3 4 5 6).

    "Test Zero-Capacity Initialization"
    zeroCapacitySet := CTSmallOrderedSet new: 0.  "Initially empty with no preallocated space"
    self assert: zeroCapacitySet isEmpty.  "Ensure it's empty initially"

    "Ensure elements can be added and size increases dynamically"
    zeroCapacitySet add: 10.
    zeroCapacitySet add: 20.
    zeroCapacitySet add: 30.

    "Verify growth occurs from zero capacity"
    self assert: zeroCapacitySet size equals: 3.
    self assert: (zeroCapacitySet asArray) equals: #(10 20 30).
]
