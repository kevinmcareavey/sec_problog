%
% SEC axioms.
%

% SEC1.
holdsAt(F, T2) :-
	happens(E, T1),
	initiates(E, F, T1),
	T1 < T2,
	not(stoppedIn(T1, F, T2)).

% SEC2a.
stoppedIn(T1, F, T2) :-
	happens(E, T),
	terminates(E, F, T),
	T1 < T,
	T < T2.

% SEC2b.
clipped(T1, F, T2) :-
	happens(E, T),
	terminates(E, F, T),
	T1 =< T,
	T < T2.

% SEC3.
holdsAt(F, T) :-
	initially(F),
	not(clipped(0, F, T)).

