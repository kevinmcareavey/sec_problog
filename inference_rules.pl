%
% Inference rules.
%

0.9::infer([happens(e(S, sit), T), subject(e(S, sit), S), act(e(S, sit), sit)]) :-
	happens(E, T),
	subject(E, S),
	orientation(E, sitting),
	holdsAt(orientation(S, standing), T).

0.9::infer([happens(e(S, stand), T), subject(e(S, stand), S), act(e(S, stand), stand)]) :-
    happens(E, T),
    subject(E, S),
    orientation(E, standing),
    holdsAt(orientation(S, sitting), T).

