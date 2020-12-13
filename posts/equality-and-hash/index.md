Consider the following situation. I define a class `Person` with two instance variables: `name` and `age`.

```Smalltalk
Object subclass: #Person   instanceVariableNames: 'name age'   classVariableNames: ''   package: 'EqualityAndHash'
```

I also provide a _"getter"_ and _"setter"_ accessors for both variables:

```Smalltalk
Person >> name
   ^ name
   
Person >> name: anObject
   name := anObject
   
Person >> age
   ^ age
   
Person >> age: anObject
   age := anObject
```

For convenience, I define the `printOn:` method to print the Person object as a string in `Name(age)` format:

```Smalltalk
Person >> printOn: aStream   aStream      nextPutAll: name;      nextPut: $(;      nextPutAll: age asString;      nextPut: $).
```

Then I create four instances of `Person`:

```Smalltalk
person1 := Person new 
   name: 'Alice';
   age: 22;
   yourself.
	
person2 := Person new
   name: 'Alice';
   age: 22;
   yourself.
	
person3 := Person new
   name: 'Bob';
   age: 24;
   yourself.
	
person4 := Person new 
   name: 'Bob';
   age: 28;
   yourself.
```

I want two people with the same name and age to be treated as the same person. Therefore, I want `person1` to be equal to `person2` and all other combinations of two people to be unequal. But instead I get the following:

```Smalltalk
person1 = person2. "false"
person1 = person3. "false"
person3 = person4. "false"
```

This happens because `Person` does not implement the equality operation and the closest implementation is the one provided by `Object`, which checks the identity of two objects:

```Smalltalk
Object >> = anObject 
   "Answer whether the receiver and the argument represent the same 
   object. If = is redefined in any subclass, consider also redefining the 
   message hash."

   ^ self == anObject 
```

To get the desired behaviour, I override the equality operator:

```Smalltalk
Person >> = anObject
   anObject class = self class
      ifFalse: [ ^ false ].
	
   ^ anObject name = name and: [ 
      anObject age = age ]
```

Now everything works as expected:

```Smalltalk
person1 = person2. "true"
person1 = person3. "false"
person3 = person4. "false"
```

However, if I put those four people into the set, I expect to have a set of three people, because `person1` and `person2` are identical. However, I get the set of four people:

```Smalltalk
{ person1 . person2 . person3 . person4 } asSet size "a Set(Alice(22) Bob(24) Alice(22) Bob(28))".
```

This happens because the set indexes objects using their hashes, and since I didn't override the `hash` method of `Person` and therefore object hashes of `person1` and `person2` are still different. **If I override the equality operator, I must also override the hash method**.

```Smalltalk
Person >> hash
   ^ name hash bitXor: age hash
```

Now the `Set` correctly identifies `person1` and `person2` as the same person:

```Smalltalk
{ person1 . person2 . person3 . person4 } asSet. "a Set(Bob(28) Alice(22) Bob(24))"
```