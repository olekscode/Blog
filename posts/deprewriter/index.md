# DepRewriter: Smart Deprecations that Automatically Fix Your Code

A couple of months ago, we have submitted a research article to the Journal of Object Technologies, in which we introduced an idea of smart deprecations that can automatically fix broken code. As you call the deprecated method, it signals a warning and then dynamically rewrites the outdated method call. This is done using the transformation rule provided by library developers as part of deprecation statement. The article is still under review and not yet accesssible to general public. But in this post, I will use simple terms and several examples to quickly explain you the general idea behing DepRewriter.

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

## Code Transformation Rules

To express the transformations that must be applied to client code in order to update it, we need a special language.

In Pharo, there is a special pattern matching language that allows us to search through code and replace portion of code with another.

| **Token** | **Meaning** | **Example** |
|---|---|---|
| \` | defines a variable | `'receiver foo` matches `x foo`, `OrderedCollection foo`, or `self foo` |
| \`@ | matches any subtree | `'@rec foo` matches `self foo` (with rec = `self`), `self size foo` (with rec = `self size`), or `(x at: 2) foo` (with rec = `(x at: 2)`) |
| \`. | matches language statement (assignment, return, messages, ...) |  |
| \`# | matches literals (string, boolean, number, symbols) | `‘#lit` size matches `3 size`, `’foo’ size`, `true size` |
| {} | used to match the enclosed code |  |

## Transforming Deprecations

Now let's add 0