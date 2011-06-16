#!/usr/local/bin/io

Matrix := Object clone

Matrix setSize := method(x, y,
	self rows := List clone
	rows setSize(y)
	for(i, 0, y-1, 1,
		rows atPut(i, List clone)
		rows at(i) setSize(x)
	)
)

Matrix atPut := method(x, y, value,
	rows at(y) atPut(x, value)	
)

Matrix at := method(x, y,
	rows at(y) at(x)
)

Matrix print := method(
	"matrix(" println
	rows foreach(
		foreach(item, (" " .. item) print)
		"" println)
	")" print
)

matrix := Matrix clone
matrix setSize(2, 3)

matrix atPut(0, 0, "pig")
matrix atPut(1, 2, "dog")
matrix at(0, 0) println

matrix println
