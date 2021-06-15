% notes(c).
% notes(d).
% notes(e).
% notes(f).
% notes(g).
% notes(a).
% notes(b).

bars(2).

%4 for whole note, 2 for half and 1 for quarter
value(1;2;4).

time(1..M) :- bars(N), M = 4*N.

{melody(T,N,V) : notes(N), value(V)} = 1:- time(T).

% the sum of the values of notes in a bar cannot excede 4
:- S = #sum{V : melody(T,N,V)}, S > 4.

% Now this is the tricky part
% How to make constraints or optimizations
% so the produced melody is actually interesting?

% For instance, we could try to minimize the number of repeated notes
% At least this would give something random
repeated(N,T1;T2) :- melody(N,T1,_), melody(N,T2,_), T1!=T2.
repeated(N,T2) :- melody(N,T1,_), melody(N,T2,_), T1!=T2.
#minimize { 1,X,T : repeated(X,T) }.
