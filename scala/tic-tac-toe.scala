class Board(
	val top: (Char, Char, Char),
	val middle: (Char, Char, Char),
	val bottom: (Char, Char, Char)
) {
	def wins(marker:Char):Boolean = lines().filter(line => win(marker, line)).size > 0 

	def lines():List[(Char, Char, Char)] = List(top, middle, bottom)

	def win(marker:Char, line:(Char, Char, Char)):Boolean = line match {
		case (a, b, c) => a == marker && b == marker && c == marker
	}
}


val board = new Board(
	('X', 'X', 'X'), 
	('X', 'X', 'X'), 
	('X', 'X', 'X') 
)
val winner = if(board.wins('X')) "X"
	else if(board.wins('O')) "O"
	else "no one"

println("The result is that " + winner + " wins.")
