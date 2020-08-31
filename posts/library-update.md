# Understanding the Problem of Library Update

Most modern software depends on multiple external libraries or frameworks. For example, a simple Java application can depend on JUnit, Mockito, Log4j, Xerces, etc. Every time the new version of an external library is released, developers of every application that depends on this library are facing a choice: either *to update* their system to the new version of the library, thus dealing with the added cost of refactoring, or *not to update* and keep using the old version of the library, thus missing out on the new or improved functionality and dealing with all the challenges of being dependent on the obsolete software.

In this post, I talk about the first situation and discuss:

1. The difference between *library update* and *library migration*
2. The general idea of automatic or semi-automatic library update

In my next post, I will discuss:

3. Different sources of information that can be used to automate the process of library update
4. What has been done in this area

## A Simple Example

Consider the following example. There is an external library `collection1.0.jar` which provides a public class `Collection` and a method `includesAllOf()` which checks if all elements of another collection passed as an argument are included in the receiver collection.

```Java
public class Collection<E> {
    ...
    public boolean includesAllOf(Collection<E> values) {
        return values.forEach(value -> {
            this.includes(value);
        });
    }
    ...
}
```

There is also a client application `main.java` which uses the method `Collection.includesAllOf()` imported from the external library `collection1.0.jar`. The client application creates a collection of three elements: `{apple, banana, pear}` and checks if both `apple` and `pear` are included in that collection.

```Java
import Collection;
...

Collection<String> products = new Collection<String>();

products.add(“apple”);
products.add(“banana”);
products.add(“pear”);

if (products.includesAllOf([“apple”, “pear”]) { ... }
```

After some time, library developers release the new version of the collection library, `collection2.0.jar`. In this version, the method `includesAllOf()` is renamed to `containsAll()`.

```Java
public class Collection<E> {
    ...
    public boolean containsAll(Collection<E> values) {
        return values.forEach(value -> {
            this.includes(value);
        });
    }
    ...
}
```

Consequently, the implementation of the client application must be changed to replace the call to the old method `Collection.includesAllOf()` with a call to the new method `Collection.containsAll()`.

```Java
import Collection;
...

Collection<String> products = new Collection<String>();

products.add(“apple”);
products.add(“banana”);
products.add(“pear”);

if (products.containsAll([“apple”, “pear”]) { ... }
```

This change of client application that is triggered by the evolution of the external library on which it depends is called the *library update*.

## Library Update vs Library Migration

There is no universally accepted vocabulary in this area and authors of various related literature use different terms interchangeably. Therefore, in this section, I would like to define the two major variations of the problem and propose the terminology which I find to be the most clear and unambiguous:

**Library Update** --- the problem of updating client systems from the old version of a library to the new one. For example, an application that depended on *JUnit 4 (v4.16.1)* has to be updated to use *JUnit 5 (v5.6.3)*.

**Library Migration** --- the problem of migrating the client system from one external library to a completely different library that serves the same or similar purpose. For example, the application that used the *easymock* testing framework has to be migrated to use *mockito* instead.

In my PhD, I am dealing with the problem of *Library Update*. The prob
em of *Library Migration*, although closely related, remains outside the scope of my research. In this series of blog posts, unless otherwise stated, I will be talking about library update as defined above.

## Automatic and Semi-automatic Library Update

The process of updating the client system to the new API of the external library often consists of multiple repetitive tasks: renaming methods or classes, replacing one method call with two or more method calls, changing the order of method arguments. In many cases, those repetitive tasks can be performed automatically. In this section, I discuss the general idea of how we can help client developers update their software by making at least part of this process automatic or semi-automatic.

The difference between **automatic** (or fully-automatic) library update and the **semi-automatic** one is that the former completely excludes the human developer from the process, while the later only proposes the actions that the developer must take.

![Figure 1. Library update](../img/LibraryUpdate.png)

The Figure above illustrates the general case of library update various actors that are involved in this process. There is an *External Library* that is maintained by a group of *library developers* and a *Client System* which is developed and maintained by the group of *client developers* (it is important to understand that in many cases there is no direct communication between the library developers, e.g. the open source community that manages JUnit, and client developers, e.g. the developers of a smartphone app located in Australia). The client system depends on the first version of the external library (*v1.0*). After some time, the library developers release the second version of the library (*v2.0*) and client developers have to update their system to use the new API and to update the dependency from v1.0 to v2.0. As I have mentioned before, this process is called the *library update*.

Some changes that have to be applied to the client system in order to update it to the new version of the library can be expressed as code transformation rules in the form *antecedent -> consequent* where *antecedent* is a regular expression that matches the piece of code that has to be replaced and *consequent* is another regular expression that provides the replacement. Other changes however are more complicated and must be applied manually by client developers.

The rules that express the most simple (and apparently the most common) code transformations that are required for library update can be provided by library developers or mined automatically either from source code or from the commit history. In my next blog post, I will do a more detailed overview of the sources of information that can be used to automatically generate the library update rules.
