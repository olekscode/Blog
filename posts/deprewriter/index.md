# DepRewriting: Smart Deprecations that Automatically Fix Your Code

In this post, I will use the simple terms and several examples to explain you the new technology that we have introcuced in our recent article.

## How Deprecations Work?

Imagine the following example. A group of developers released a small open source library `Collection v1.0.0`. This could be part of the code from `Collection.jar`:

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
You decided to use this library, so you import it in your java file and write:

```Java
import Collection;
...
products.includesAllOf([“apple”, “pear”]);
```
In second version of the library, developers decided to rename `includesAllOf()` method to `includesAll()`. As a result, your code calls `includesAllOf()` and raises the `NotFound` exception. This change in the library is called the **breaking change**. It causes client code that was designed for the old version of the library to break on the new version.

To ensure that client software does not break, developers do the following: they add a new method `includesAll()` and keep the old method `includesAllOf()` but mark it as **deprecated**. The client code will work without errors, but it will raise a warning notifying client developers that the method `includesAllOf()` will be removed in the next release.

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

This gives client developers time to fix their code and reduces the potential number of errors.

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