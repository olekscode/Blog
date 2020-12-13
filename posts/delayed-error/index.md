```c
typedef struct {
    int size;
    int* elements;
} SmartArray;
```

```c
int get(SmartArray* array, int index) {
    return array->elements[index];
}
```

```c
void set(SmartArray* array, int index, int value) {
    array->elements[index] = value;
}
```

```c
void swap(SmartArray* array, int i, int j) {
    int temp = get(array, i);
    set(array, i, get(array, j));
    set(array, j, temp);
}
```

```c
void sort(SmartArray* array) {
    for (int i = 0; i < array->size; ++i) {
        for (int j = i + 1; j < array->size; ++j) {
            if (get(array, i) > get(array, j)) {
                swap(array, i, j);
            }
        }
    }
}
```