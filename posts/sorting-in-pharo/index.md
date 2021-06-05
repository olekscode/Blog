# How to Sort a Collection in Pharo

Collections in Pharo answer to two messages that allow us to sort their elements:

- `collection sorted: sortingBlock` - creates a new collection with sorted elements; the original collection is left unchanged
- `collection sort: sortingBlock` - sorts element inside the given collection; modifies the receiver

Sorting block is a two-argument block that will be applied to every two elements in the collection and tell us if first element is greater than the second one or not.

For example, we can sort a collection of numbers in ascending order:

```Smalltalk
#(3 2 1 4) sorted: [ :a :b | a < b ]. "#(1 2 3 4)"
```

Or sort a collection of students in the descending order of their names:

```Smalltalk
students sorted: [ :a :b | a name > b name ].
```
(in this case, we are using the `#>` message defined by String class which compares two strings lexicographically - like in dictionary)

We can also sort a collection of rectangles first by the hex value of their colors and then by their areas:

```Smalltalk
rectangles sorted: [ :a :b |
    (a color asHexString > b color asHexString) and: [ 
        a area > b area ] ].
```