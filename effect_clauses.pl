%
% Effect clauses.
%

initiates(E, location(S, door), _) :-
	subject(E, S),
	act(E, board).

initiates(E, orientation(S, standing), _) :-
	subject(E, S),
	act(E, board).

initiates(E, gender(S, G), _) :-
	subject(E, S),
	gender(E, G).

initiates(E, location(S, L), _) :-
	subject(E, S),
	location(E, L).

initiates(E, orientation(S, O), _) :-
	subject(E, S),
	orientation(E, O).

terminates(E, location(S, _), _) :-
	subject(E, S),
	act(E, board).

terminates(E, orientation(S, _), _) :-
	subject(E, S),
	act(E, board).

terminates(E, gender(S, _), _) :-
	subject(E, S),
	gender(E, _).

terminates(E, location(S, _), _) :-
	subject(E, S),
	location(E, _).

terminates(E, orientation(S, _), _) :-
	subject(E, S),
	orientation(E, _).

terminates(E, location(S, _), _) :-
	subject(E, S),
	act(E, exit).

terminates(E, orientation(S, _), _) :-
	subject(E, S),
	act(E, exit).

