class Board(
	val top: (Char, Char, Char),
	val middle: (Char, Char, Char),
	val bottom: (Char, Char, Char)
) {
	def wins(marker:Char):Boolean = lines().filter(line => win(marker, line)).size > 0 

	def win(marker:Char, line:(Char, Char, Char)):Boolean = line match {
		case (a, b, c) => a == marker && b == marker && c == marker
	}

	def lines():List[(Char, Char, Char)] = {
		val (a, b, c) = top
		val (d, e, f) =	middle 
		val (h, i, j) = bottom 

		val verticals = List((a, d, h), (b, e, i), (c, f, j)) 
		val horizontals = List(top, middle, bottom)
		val diagonals = List((a, e, j), (h, e, c))

		horizontals ++ verticals ++ diagonals
	}
}

val board = new Board(
	('X', '_', 'O'), 
	('_', 'O', '_'), 
	('O', 'X', 'X') 
)

val winner = if(board.wins('X')) "'X'"
	else if(board.wins('O')) "'O'"
	else "no one"

println("The result is that " + winner + " wins.")
