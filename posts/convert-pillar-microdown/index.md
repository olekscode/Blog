# Converting Pillar to Microdown

[Pillar](https://github.com/pillar-markup/pillar) is a markup language and toolkit implemented in [Pharo](https://pharo.org) that allows you to quickly write books, create documentation in the form of booklets or web pages.
Here are some books that were written in Pillar: [Pharo by Example](http://books.pharo.org/pharo-by-example9/), [Enterprise Pharo](http://books.pharo.org/enterprise-pharo/), [Pharo with Style](http://books.pharo.org/booklet-WithStyle/), [Learning Object-Oriented Programming, Design and TDD with Pharo](http://books.pharo.org/learning-oop/), [The Spec UI Framework](http://books.pharo.org/spec-tutorial/).
There are also many smaller booklets that can be found at the GitHub page of [SquareBracketAssociates](https://github.com/SquareBracketAssociates).

Recently, Pharo Community has released [Microdown]() - a new dialect of [Markdown]() that provides anchors, built-in math support, and most importantly, the support for extensions.

It is planned that in the future, Microdown should completely replace Pillar.
To make migration easier, developers provide a simple tool that can convert entire books or specific chapters from Pillar to Microdown.
In this post, I provide a small example of creating a Pillar book, converting it to Microdown, and finally compiling it to PDF.

To follow this example, you must first [install Pillar](https://github.com/pillar-markup/pillar#installation).

## Creating a Book with Pillar

First, create an empty directory where you want your book to be generated.

```
mkdir my-book
cd my-book
```

Run the following command to generate a simple book template (in pillar, those templates are called archetypes).

```
pillar archetype book
```

This will generate the following:

- `pillar.conf` file containing the metadata of your book sucha as title, authors, series, language, etc.
- `index.pillar` file that combines all the chapters and defines the book structure.
- `_support/` folder containing all the dependencies and resources that are needed to generate the book in different formats, such as PDF, HTML, EPUB, ect.
- `Chapters/` folder containing two other folders: `Chapter1/` and `Chapter2/`. Each `ChapterX/` folder will contain:
 - `chapterX.pillar` file with generated text of the chapter.
 - `figures/` folder containing the images that are used in this chapter.

Now you can compile the book to PDF using:

```
pillar build pdf
```

Or to HTML using:

```
pillar build html
```

The result will be generated inside the `_result` folder.

## Converting the Book to Microdown

Run the following command to convert the entire book to Microdown:

```
pillar convertBook index.pillar
```

This will convert all `*.pillar` files (in our case, `index.pillar`, `chapter1.pillar`, and `chapter2.pillar`) to Microdown. It will also generate the new `pillar.conf` file.

You can also convert a specific chapter using:

```
pillar convertChapter Chapters/Chapter1/chapter1.pillar
```

As you probably noticed, the old `*.pillar` files were not removed. The tool simply generated the corresponding `*.md` files.
The old `pillar.conf` file was also retained and renamed to `pillarconf.old`.

We can remove all those files as they are not needed anymore.

```
rm **/*.pillar pillarconf.old
```

Now we can build the PDF or HTML of the book written in Microdown (same command as for `*.pillar` books).

```
pillar build pdf
```

**Note:** If you do not want to remove the `*.pillar` fiels, then the tool will be confused, not knowing which version to compile.
In this case, you should specify explicitly the `index.*` file:

```
pillar build pdf index.md
```