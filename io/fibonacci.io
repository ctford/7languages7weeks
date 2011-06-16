#!/usr/local/bin/io

Number fibonacci := method(
	if(self <= 2,
		1,
		(self-1) fibonacci + (self-2) fibonacci
	)
)

for(i, 1, 10, i fibonacci println)
