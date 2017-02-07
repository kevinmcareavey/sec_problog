%
% Inference rules.
%

0.9::infer([happens(e(S), T), subject(e(S), S), act(e(S), sit)]) :-
	happens(E, T),
	subject(E, S),
	orientation(E, sitting),
	holdsAt(orientation(S, standing), T).

