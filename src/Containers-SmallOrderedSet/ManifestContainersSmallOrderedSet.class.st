"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestContainersSmallOrderedSet',
	#superclass : 'PackageManifest',
	#category : 'Containers-SmallOrderedSet-Manifest',
	#package : 'Containers-SmallOrderedSet',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestContainersSmallOrderedSet class >> ruleSelfSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CTSmallOrderedSetTest #testRemoveIndex #false)) #'2025-03-27T03:30:19.29737+05:30') )
]

{ #category : 'code-critics' }
ManifestContainersSmallOrderedSet class >> ruleSentNotImplementedRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CTSmallOrderedSetTest #testRemoveIndex #false)) #'2025-03-27T03:30:22.425487+05:30') )
]

{ #category : 'code-critics' }
ManifestContainersSmallOrderedSet class >> ruleUnoptimizedToDoRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#CTSmallOrderedSet #removeIndex: #false)) #'2025-03-27T03:26:16.767967+05:30') )
]
