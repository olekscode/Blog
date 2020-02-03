# Lorem Ipsum Dolor Sit Amet

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

## Examples of Code Highlighting

### Pharo Code

```smalltalk
Object >> printOn: aStream
	"print the name of my class preceded with letter 'a'"
	aStream nextPutAll: 'a ', self class name.
```

### Java Code

```java
public class HelloWorld {

    public static void main(String[] args) {
        // Prints "Hello, World" to the terminal window.
        System.out.println("Hello, World");
    }
}
```

### C Code

```c
#include <stdio.h>
#include "smartarray.h"

void print(SmartArray* array) {
  // Print the given array in this format:
  // SmartArray[4] {42, 0, 25, -1}

  printf("SmartArray[%d]: {", array->size);

  for (int i = 0; i < array->size - 1; ++i) {
    printf("%d, ", get(array, i));
  }

  if (array->size > 0) {
    printf("%d", get(array, array->size - 1));
  }
  printf("}\n");
}
```

### LaTeX Code

```latex
\documentclass{article}

\usepackage[a4paper, total={6in, 8in}]{geometry}

\usepackage{graphicx} % for images
\usepackage{float}  % for float options such as [H]
\usepackage{authblk}  % for affiliations
\usepackage{url}  % for URL links
\usepackage{xspace}  % for smart spaces
\usepackage{xcolor}  % for comments
\usepackage{ifthen}  % for comments
\usepackage{amssymb}  % for comments
\usepackage[utf8]{inputenc} % for French accents

\makeatletter
\def\url@leostyle{%
  \@ifundefined{selectfont}{\def\UrlFont{\sf}}{\def\UrlFont{\small\sffamily}}}
\makeatother
%% Now actually use the newly defined style.
\urlstyle{leo}
```

## Math Examples

When \(a \ne 0\), there are two solutions to \(ax^2 + bx + c = 0\) and they are
  \[x = {-b \pm \sqrt{b^2-4ac} \over 2a}.\]
  
## Image Example

![](..)