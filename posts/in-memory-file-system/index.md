# Testing with the In-Memory File System

Every now and then we need to write a test for a method that manipulates files in a file system. For example, the method that saves a data frame to CSV.

Pharo allows us to create virtual file systems that only exist in the runtime memory. Those are objects that respond to the same API as a real file system. They allow us to create, read, modify, or delete files, organize them into folders, etc.

```Smalltalk
fs := FileSystem memory.
file := (fs / 'src' / 'hello.txt') ensureCreateFile.

file writeStreamDo: [ :stream |	stream nextPutAll: 'Hello world!' ].
```

Now we can inspect the root of the file system:

```Smalltalk
fs root.
```