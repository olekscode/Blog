# FFI Basics: Calling Native C Functions from Pharo

**FFI** stands for Foreign Function Interface. It allows one to call the code of one programming language from another. This can be useful for speeding up certain operations by letting them be executed by a natively compiled programming language such as C or Fortran.

## Building a Simple C Library

We will create a simple math library that contains two functions. Below are the contents of the `math.h` file:

```C
int factorial(int);
double average(double*,int);
```

We implement those functions in `math.c`:

```C
int factorial(int n) {
    return n > 1 ? n * factorial(n-1) : 1;
}

double average(double* numbers, int size) {
    double sum = 0;

    for (int i = 0; i < size; ++i) {
        sum += numbers[i];
    }

    return sum / size;
}
```

Now we compile them:

```
gcc math.c -c -fPIC
```
```
gcc math.o -shared -o libmath.so
```

Now we create a small `main.c` file to check if everything works

```C
#include <stdio.h>
#include "math.h"

int main(void) {
    double numbers[5] = {2.1, 3.5, 0.2, -7.2, 0};

    printf("%d\n", factorial(5));
    printf("%f\n", average(numbers, 5));
}
```

Finally, we compile it by including the shared library:

```
gcc -L . main.c -lmath -o main
```

And now we run it

```
./main
120
-0.280000
```

## Calling the Library Using FFI in Pharo

```Smalltalk
FFILibrary << #MathLibrary    slots: {};    package: 'MathFFI'
```
```Smalltalk
FFILibrary >> macLibraryName    ^ FFIMacLibraryFinder new         userPaths: { '.' };        findAnyLibrary: #('libmath.so').
```
```Smalltalk
Object << #Math    slots: {};    package: 'MathFFI'
```
```Smalltalk
Math >> ffiLibrary    ^ MathLibrary 
```
```Smalltalk
Math >> ffiFactorial: number    ^ self ffiCall: #(int factorial(int number))
```
```Smalltalk
Math >> ffiAverage: doubleArray size: size    ^ self ffiCall: #(double average(FFIExternalArray doubleArray, int size))
```
```Smalltalk
Math >> factorial: aNumber    aNumber < 0 ifTrue: [ self error: 'Not valid for negative integers' ].    ^ self ffiFactorial: aNumber.
```
```Smalltalk
Math >> average: aCollection    | array |    array := FFIExternalArray newType: 'double' size: aCollection size.    array fillFrom: aCollection with: [ :x | x ].    ^ self ffiAverage: array size: aCollection size.
```