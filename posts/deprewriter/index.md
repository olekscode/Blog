# DepRewriter: Smart Deprecations that Automatically Fix Your Code

A couple of months ago, we have submitted a research article to [The Journal of Object Technology](http://www.jot.fm/), in which we present the smart deprecations that can automatically fix broken code. When you call a deprecated method, it signals a warning and then dynamically rewrites the outdated method call. This is done using the transformation rule provided by library developers as part of deprecation statement. The article is still under review and not yet accesssible to general public. But in this post, I will use simple terms and several examples to quickly explain you the general idea behing DepRewriter.

## What are Deprecations?

I will start by explaining method deprecations. If you are already familiar with them, feel free to jump to the next section.

Imagine the following example. You are using a little open source Java library called `Collection v1.0.0`. It provides a class `Collection` which has a method `includesAllOf()`. The method checks if all evement of another collection are included in this collection.

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
In your code you use this library in the following way:

```Java
import Collection;
...
products.includesAllOf([“apple”, “pear”]);
```
After some time, the new version of `Collection` is released, `v2.0.0`. In this version, the method `includesAllOf()` was renamed to `includesAll()`.

Now your code which is still calling `includesAllOf()` will break by raising the `NotFound` exception. In this case, we say that developers introduced the **breaking change** into the `Collection` library. It makes client code that was designed for the old version of the library incompatible with the new version.

The common way of fixing these problems are **deprecations**. Instead of immeditely removing the feature from a software library, it is first marked as deprecated (_"to be removed in the future"_) which ensures backward compatibility and gives client developers time to update their code.

In our case, `Collection v2.0.0` should not replace `includesAllOf()` with `includesAll()`. Instead, it should keep the old method `includesAllOf()`, mark it as deprecated, and also add a new method `includesAll(). Then in the following release `Collection v3.0.0` the deprecated method `includesAllOf()` will be finally removed.

Programming languages have different syntax for expressing deprecations. In Java

```Java
public class Collection<E> {
  ...
  public boolean includesAll(Collection<E> values) {
    return values.forEach(value -> {
      this.includes(value);
    });
  }

  @Deprecated
  public boolean includesAllOf(Collection<E> values) {
    return this.includesAll(values);
  }
  ...
}
```

**Note:** In this case, the old and the new methods have same implementation so to avoid code duplication, we simply call the new method from the old one.


## Transforming Deprecations

With every new release of a software library, certain parts of API may be deprecated. Those deprecations are reported to client developers either as part of documentation (release notes) or in the form of annotation (as demonstrated in the previous section). It is then the responsibility of client developers to find all calls to deprected methods in their code base and either remove them or replace them with correct substite from the new API. Modern IDEs can make the job easier by providing powerful search tools, highlighting deprecated code, and displaying the line of code from which the deprecation warning was fired. Still, it is a boring and repetitive task that could be simplified and partially automated.

[Pharo](https://pharo.org/) provides a poverful engine of _transforming deprecations_ (a.k.a. _rewriting deprecations_). When deprecating a method, library developers can specify a transformation rule that will be used to automatically fix client code. Here is the example of a deprecated method with a transformation rule written in Pharo:

```Smalltalk
Collection >> includesAllOf: values
  self
    deprecated: ‘Use #includesAll: instead’
    transformWith: ‘`@rec includesAllOf: `@arg’ ->
                   ‘`@rec includesAll: `@arg’.

  ^ self includesAll: values
```

The first line declares a method `includesAllOf:` of class `Collection`. The method takes one argument: `value`. Lines 2-5 deprecate this method by calling abother method `deprecated:transformWith:` which is undestood by all subclasses of `Object`. The first argument is a deprecation string that will be displayed in the deprecation warning: `'Use #includesAll: instead'`. The second argument is a transformation rule: `'‘@rec includesAllOf: ’@arg' -> '’@rec includesAll: ’@arg'`. The last line of the deprecated method calls the new method `includesAll:`.

The transformation rule consists of two parts: antecedent (left hand side) and consequent (right hang side). Both are expressions written in a pattern matching language (similar to regex but for code). Antecedent matches the piece of code that needs to be replaced and consequent defines the replacement. Tokens that start with '@ are named variables. The antecedent above matches all method calls to includesAllOf:. The receiver is stored in variable '@rec, the argent is stored in variable '@arg. Then consequent expression generates the call to includesAll: using the same receiver and argument. 

When client calls the deprecated method includesAllOf:, he/she will receive a deprecation warning, then the deprecated method call inside client code will be automatically replaced with the call to includesAll:. Finally, the new method includesAll: will be called.

Client developer can change the configurations to disable warnings or disable automatic rewriting and be asked explicitly before any changes to the code are made.


## References

* Stéphane Ducasse, Guillermo Polito, Oleksandr Zaitsev, Marcus Denker, and Pablo Tesone. _Deprewriter: On the fly rewriting method deprecations_ (2020) [unpublished, submitted to JOT]
* Stéphane Ducasse and Oleksandr Zaitsev. [_ParseTreeWriter Explained_](https://github.com/SquareBracketAssociates/Booklet-Rewriter/releases/tag/continuous). Square Bracket Associates, November 2020 [draft]