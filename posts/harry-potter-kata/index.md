# Harry Potter Kata

## Step 1. Implementing the HPBook class

```st
TestCase << #HPBookTest
```
```st
HPBookTest >> testTitle
```
```st
Object << #HPBook
```
```st
HPBook >> title
	
HPBook >> title: aString 
```
```st
HPBook class >> title: aString 
```

## Implementing the HBSeller class

```st
TestCase << #HPSellerTest
```
```st
HPSellerTest >> testPriceOfOneBook
```
```st
Object << #HPSeller
```
```st
HPSeller >> initialize
```
```st
HPSeller >> basePriceOfOneBook
	In our example, all books cost 8 euros"
```
```st
HPSeller >> discountForSet: aSet
```
```st
HPSeller >> priceOfSet: aSet
	basePrice := self basePriceOfOneBook * aSet size.
	
```
```st
HPSeller >> priceOf: aCollection 
```

```st
HPSeller >> allSetsOfBooks: aCollection
```

```st
HPSeller >> priceOf: aCollection 
	
	price := 0.
	
	[ counts isEmpty ] whileFalse: [
		min := counts min.
		
		discount := discountMapping at: counts size.
		price := price + (min * counts size * self basePriceOfOneBook * discount).
		
		counts := counts
			collect: [ :each | each - min ]
			thenReject: [ :each | each = 0 ] ].
```
```st
setUp
	super setUp.
	
	book1 := HPBook title: 'Harry Potter and the Philosopher''s Stone'.
	book2 := HPBook title: 'Harry Potter and the Chamber of Secrets'.
	book3 := HPBook title: 'Harry Potter and the Prisoner of Azkaban'.
	book4 := HPBook title: 'Harry Potter and the Goblet of Fire'.
	book5 := HPBook title: 'Harry Potter and the Order of Phoenix'.
```