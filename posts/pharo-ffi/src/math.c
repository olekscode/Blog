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