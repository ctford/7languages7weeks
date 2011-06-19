class Board(val top: Boolean) {
	def win():Boolean = top
}


val board = new Board(true)

val message = board match {
	case b if b.win() => "X wins!"
}
