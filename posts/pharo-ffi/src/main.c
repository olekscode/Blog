#include <stdio.h>
#include "math.h"

int main(void) {
    double numbers[5] = {2.1, 3.5, 0.2, -7.2, 0};

    printf("%d\n", factorial(5));
    printf("%f\n", average(numbers, 5));
}