# Design Coffee Club: Shared Pools

Design Coffee Club is a nice initiative that we started at [RMoD](https://rmod.inria.fr).
Once a week, we meet and discuss some topic related to software design.
This week, [Stéphane Ducasse](http://stephane.ducasse.free.fr/) was presenting shared pools in [Pharo](https://pharo.org). In this blog post, I will briefly summarize his lecture.

In Pharo, there are three types of shared variables:

* **Global variables** - accessible everywhere.
* **Class variables** - accessible both from the class side and the instance side of a class that defines them as well as all of its subclasses.
* **Shared pools** - shared among the group of classes that do not need to be in the same hierarchy.

## Global Variables

## Class Variables

A class variable allows us to share a value among multiple classes of the same hierarchy.
It can be accessed both from class side and the instance side of a class that defines it as well as all of its subclasses.

### Class Variables VS Class Instance Variables

The _class variables_ in Pharo should not be confused with _class instance variables_.
Class instance variables are shared among all instances of the class but not its subclasses.
For example, we can add a class instance variable `count` to keep track of the number of instances of a given class.
But every subclass will have its own count.

Class variables are different. They are shared among the subclasses.
This means that if a `count` was implemented as a class variable, once incremented, it would change for all subclasses.

By convention, the names of instance variables and class instance variables in Pharo begin with a lowercase letter. The names of shared variables (global variables, class variables, etc.) begin with an uppercase letter).

## Shared Pools

Sometimes we want to share a group of values (usually constant) over multiple hierarchies.
We do not want to repeat the initialization in every hierarchy and create many copies of the same object. 
This can be achieved with a shared pool.

**Shared Pool** is a class that defines and initializes a group of shared variables. It can be added to other classes and they will all get access to the same variables defined by a shared pool.

Here is an example of a shared pool that defines the chronology constants.

```Smalltalk
SharedPool << #ChronologyConstants
    slots: {};
    sharedVariables: { #NanosInSecond . #MonthNames . #SecondsInHour .
        #SecondsInDay . #DayNames . #DaysInMonth . #HoursInDay . #NanosInMillisecond .
        #SecondsInMinute . #SqueakEpoch . #MinutesInHour . #MicrosecondsInDay };
    tag: 'Chronology';
    package: 'Kernel'
```

Each constant is now initialized in the `initialize` method on the class side of `ChronologyConstant`.

```Smalltalk
ChronologyConstants class >> initialize
    "ChronologyConstants initialize"
    SqueakEpoch := 2415386. "Julian day number of 1 Jan 1901"
    SecondsInDay := 86400.
    MicrosecondsInDay := SecondsInDay * 1e6.
    SecondsInHour := 3600.
    SecondsInMinute := 60.
    MinutesInHour := 60.
    HoursInDay := 24.
    NanosInSecond := 10 raisedTo: 9.
    NanosInMillisecond := 10 raisedTo: 6.
    DayNames := #(Sunday Monday Tuesday Wednesday Thursday Friday Saturday).
    MonthNames := #(January February March April May June July August September October November December).
    DaysInMonth := #(31 28 31 30 31 30 31 31 30 31 30 31).
```

This shared pool can now be added to any class in the system.
In the example below, we define a `DateAndTime` class (subclass of `Magnitude`) with four instance variables: `seconds`, `offset`, `julianDayNumber`, and `nanos`, two shared variables: `ClockProvider` and `LocalTimeZoneCache`, as well as a shared pool `ChronologyConstants`.

```Smalltalk
Magnitude << #DateAndTime
    slots: { #seconds . #offset . #julianDayNumber . #nanos };
    sharedVariables: { #ClockProvider . #LocalTimeZoneCache };
    sharedPools: { ChronologyConstants };
    package: 'Kernel'
```

Shared variables defined in a shared pool can now be accessed anywhere in the `DateAndTime ` class, just like its own shared variables.
In the method below, `SecondsInDay` is a shared variable that is defined by the `ChronologyConstants` shared pool.

```Smalltalk
DateAndTime >> secondsSinceMidnightLocalTime
    ^ self localSeconds \\ SecondsInDay
```

One very common use case for shared pools is C library binding through FFI.
In this case, we often have to define many constants for numbers and special types (`uint16`, `STH_float64`, etc.) that will be shared by all classes of the project.
It is very handy to define those constants in a single project-wide shared pool and use it in every class.
 
### Why shared pools should be constant?

Even though it is possible, it is not considered a good practice to use shared pools with variables that can change.
Shared pools can be used anywhere in the system.
If we modify a variable in a shared poo, this change will be applied globally and this can lead to unexpected behavior in different locations.

## Design Pattern: Sharing with Instances

**Problem:** Shared variables can not be substituted without changing the source code or modifying their values (something that should not be done). This makes it hard to test the code that is using a shared variable. Especially if the variable contains a large amount of data, database connection, network connection, etc. This raises a question: _How can we use a shared variable by default but also substitute it with an instance variable if needed?_

**Solution:** We can create an instance variable with the same name as the shared variable. In the `initialize` method (acts like a constructor in Pharo), we assign the default value to the instance variable - the value of a shared variable. Outside the `initialize` method, we never access the shared variable itself but only the instance variable (which points to the same object by default). We also provide a setter for the instance variable which allows us to change its value if needed.

## References

* [Pharo by Example](https://books.pharo.org/updated-pharo-by-example/pdf/2018-09-29-UpdatedPharoByExample.pdf). Chapter 6.9. Shared Variables