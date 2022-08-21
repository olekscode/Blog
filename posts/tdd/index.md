# A Guided Example of Test-Driven Development

Although learning to code is relatively simple, many beginner programmers find it hard to develop complex projects –– the more code they write, the less confident they feel about it.
System grows, becomes more complex and harder to understand.
Bugs become more frequent and even small changes become painful and time consuming.
 
It is even harder to contribute to large existing systems that were built and maintained by other people.
Having a very limited knowledge of a large software system, how can we introduce changes and be sure that they do not break the existing functionality?

In this post, I will introduce the software development practice that allows to overcome all those challenges and build software in a confident step-by-step manner.
This practice is known as _Test-Driven Development_ (TDD).
Instead of developing software first and testing it later, the TDD practitioners start by writing a test for the feature that does not exist yet.
Naturally, this results in a failing test, which proves that the test is capable of capturing the absence of the feature.
Then developers write _as little as possible_ code to make the test pass.
The practice of test-driven development brings many benefits to its practitioners:

- it increases the productivity of programming;
- improves the quality of code and leads to the better design of a system;
- it offers constant validation of correctness;
- it encourages us to make small incremental changes and commit often, which leads to more modularized, flexible, and extensible code;
- and **most importantly**, it allows us to develop software with more confidence.

In the following sections of this post, I will briefly explain the TDD workflow, then I will guide you through an example, in which we will use TDD to implement a system that sells Harry Potter books. The goal of this exercise is getting used to the TDD workflow and understanding its benefits.

## The TDD Workflow

In the picture below, you can see the visualization of the test-driven development workflow. It consists of two parts that are peformed iteratively:

- **Code-driven testing** –– add a new feature to the code by writing a failing test and then making it pass; ideally, every new feature should only be added to the system (or part of it) that is fully tested.
- **Refactoring** –– improve the quality of code without changing its functionality; this is ensured by constantly running the tests and making sure that they succeed.

![](figures/tdd-lifecycle.png)

The whole workflow consists of five steps (the numbers are the same as in the picture above):

1. Add a test
2. Run all tests. The new test should fail for expected reasons
3. Write the simplest code that passes the new test
4. All tests should now pass
5. Refactor as needed, using tests after each refactor to ensure that functionality is preserved

**Important.** In practice, it is always tempting to implement 
The tests must be written before the functionality that is being testsed.

## Step 1. Implementing the HPBook class

```st
TestCase << #HPBookTest	slots: {};	package: 'HarryPotterKata-Tests'
```
```st
HPBookTest >> testTitle	| title book |	title := 'Harry Potter and the Philosopher''s Stone'.	book := HPBook title: title.	self assert: book title equals: title.
```
```st
Object << #HPBook	slots: { #title };	package: 'HarryPotterKata'
```
```st
HPBook >> title	^ title
	
HPBook >> title: aString 	title := aString
```
```st
HPBook class >> title: aString 	^ self new		title: aString;		yourself 
```

## Implementing the HBSeller class

```st
TestCase << #HPSellerTest	slots: {};	package: 'HarryPotterKata-Tests'
```
```st
HPSellerTest >> testPriceOfOneBook	| book seller books expectedPrice sellerPrice |		book := HPBook title: 'Harry Potter and the Chamber of Secrets'.	seller := HPSeller new.		books := { book }.		expectedPrice := 8.	sellerPrice := seller priceOf: books.		self assert: sellerPrice equals: expectedPrice.
```
```st
Object << #HPSeller	slots: { #discountMapping };	package: 'HarryPotterKata'
```
```st
HPSeller >> initialize	super initialize.	discountMapping := #(1 0.95 0.9 0.8 0.75).
```
```st
HPSeller >> basePriceOfOneBook	"Price of one book without discounts.
	In our example, all books cost 8 euros"	^ 8
```
```st
HPSeller >> discountForSet: aSet	^ discountMapping at: aSet size.
```
```st
HPSeller >> priceOfSet: aSet	| basePrice discount |
	basePrice := self basePriceOfOneBook * aSet size.	discount := self discountForSet: aSet.
		^ basePrice * discount.
```
```st
HPSeller >> priceOf: aCollection 	| sets |	sets := self allSetsOfBooks: aCollection.		^ sets inject: 0 into: [ :sum :set |		sum + (self priceOfSet: set) ]
```

```st
HPSeller >> allSetsOfBooks: aCollection	| sets set |	sets := OrderedCollection new.		aCollection do: [ :book |		set := sets			detect: [ :each | (each includes: book title) not ]			ifNone: [ sets add: Set new ].					set add: book title ].		^ sets
```

```st
HPSeller >> priceOf: aCollection 	| counts price |
		counts := aCollection asBag valuesAndCounts values.
	price := 0.
	
	[ counts isEmpty ] whileFalse: [
		min := counts min.
		
		discount := discountMapping at: counts size.
		price := price + (min * counts size * self basePriceOfOneBook * discount).
		
		counts := counts
			collect: [ :each | each - min ]
			thenReject: [ :each | each = 0 ] ].		^ price
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