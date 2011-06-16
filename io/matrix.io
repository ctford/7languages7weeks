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

Matrix foreach := method(
	iterating_variable := call message argAt(0)
	rows foreach(row,
		row foreach(item,
			iterating_variable := item
			doMessage(call message argAt(1))
		)
	)
)

matrix := Matrix clone
matrix setSize(2, 3)

matrix atPut(0, 0, "pig")
matrix atPut(1, 2, "dog")
matrix at(0, 0) println

matrix println
matrix foreach(item, item println)
