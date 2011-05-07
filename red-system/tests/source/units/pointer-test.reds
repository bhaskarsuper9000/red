Red/System [
	Title:   "Red/System pointer! datatype test script"
	Author:  "Nenad Rakocevic"
	File: 	 %pointer-test.reds
	Rights:  "Copyright (C) 2011 Nenad Rakocevic. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include %../../quick-test/quick-test.reds

~~~start-file~~~ "pointer!"

===start-group=== "Pointers simple read/write tests"

	--test-- "pointer-rw-1"
	p-struct: struct [n [integer!] m [integer!]]
	pA: pointer [integer!]
	pB: pointer [integer!]

	p-struct/n: 123
	--assert p-struct/n = 123

	--test-- "pointer-rw-2"
	pA: as [pointer! [integer!]] p-struct
	pA/value: 987
	--assert p-struct/n = 987
	pA/1: 987
	--assert p-struct/n = 987

	--test-- "pointer-rw-3"
	p-struct/n: 12345
	--assert pA/value = 12345
	--assert pA/1 = 12345

	--test-- "pointer-rw-4"
	p-int: 456789
	pA/2: p-int
	--assert p-struct/m = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "pointer-rw-5"
	p-idx: 1
	pA/p-idx: 369
	--assert p-struct/n = 369

	--test-- "pointer-rw-6"
	p-idx: 2
	pA/p-idx: 963
	--assert p-struct/m = 963

	--test-- "pointer-rw-7"
	p-struct/n: 12345
	p-int: 147258
	p-struct/m: p-int
	--assert pA/2 = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "pointer-rw-8"
	pB: pA
	--assert pB/value = 12345

	--test-- "pointer-rw-9"
	foo-pointer: func [
		a [pointer!]			;-- should be [pointer! [integer!]]	(validation not fully implemented yet)
		return: [pointer!]		;-- should be [pointer! [integer!]] (validation not fully implemented yet)
	][
		a
	]

	pB: foo-pointer pA 
	--assert pB/value = 12345

	pointer-str: struct [
		A [pointer! [integer!]]
		B [pointer! [integer!]]
		sub [
			struct! [
				C [pointer! [integer!]]
			]
		]
	]
	pointer-str/sub: struct [C [pointer! [integer!]]]

	--test-- "pointer-rw-10"
	pointer-str/A: pA
	--assert pointer-str/A/value = 12345

	--test-- "pointer-rw-11"
	pointer-str/A/value: 258369147
	--assert p-struct/n = 258369147
	--assert p-struct/m = p-int				;-- look for memory corruption			

	--test-- "pointer-rw-12"
	pointer-str/sub/C: pA
	--assert pointer-str/sub/C/value = 258369147

	--test-- "pointer-rw-13"
	pointer-str/sub/C/2: 987654321
	--assert p-struct/m = 987654321


===end-group===

~~~end-file~~~