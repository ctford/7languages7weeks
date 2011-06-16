#!/usr/local/bin/io

normalDivide := Number getSlot("/")
Number / := method(n, 
	if(n == 0,
		0,
		normalDivide(n)
	)
)

for(i, 4, 0, -1, (4 / i) println)
