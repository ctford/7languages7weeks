% Describes a solution to the n-queens problem.
queens(Queens) :-
	length(Queens, BoardSize),
	candidate(Queens, BoardSize, BoardSize),
	peaceful(Queens).

% Describes a potential solution.
candidate([(1, _)], 1, _).
candidate([(N, Y)|Rest], N, Max) :-
	Next is N - 1,
	legal((N, Y), Max, Max),
	candidate(Rest, Next, Max).

% Describes a set of Queens who cannot attack each other.
peaceful([]).
peaceful([Queen|Rest]) :-
	\+conflict(Queen, Rest),
	peaceful(Rest).

% Describes a legal position given a maximum width and depth.
legal((MaxX, MaxY), MaxX, MaxY).
legal(Position, MaxX, MaxY) :- 
	(Thinner is MaxX-1, Thinner > 0, legal(Position, Thinner, MaxY));
	(Shallower is MaxY-1, Shallower > 0, legal(Position, MaxX, Shallower)).

% Describes a queen in conflict with a group of other queens.
conflict(Queen, [Rival|Rest]) :-
	conflicting(Queen, Rival);
	conflict(Queen, Rest).

% Describes two queens who are able to attack each other.
conflicting(Q1, Q2) :-
	straight(Q1, Q2);
	diagonal(Q1, Q2).

% Describes two queens who are able to attack each other along a rank or file.
straight((X, _), (X, _)).
straight((_, Y), (_, Y)).

% Describes two queens who are able to attack each other along a diagonal.
diagonal((X1, Y1), (X2, Y2)) :-
	RankDifference = (X1-X2),
	FileDifference = (Y1-Y2),
	RankDifference = FileDifference.
