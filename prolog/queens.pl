
legal((X,Y), Size) :- X =< Size, Y =< Size.

allLegal([], _).
allLegal([Head|Tail], Size) :- legal(Head, Size), allLegal(Tail, Size).

queens(Queens) :- length(Queens, Length), allLegal(Queens, Length).

