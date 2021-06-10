% We have all the notes
% We can produce simple melodies for a set number of bars
% Of course, the beat will be set to 4/4 for simplicity
% notes(c).
% notes(d).
% notes(e).
% notes(f).
% notes(g).
% notes(a).
% notes(b).

bars(2).
time(1..M) :- bars(N), M = 4*N.
{melody(N,T) : notes(N)} = 1:- time(T).

% Now this is the tricky part
% How to make constraints or optimizations
% so the produced melody is actually interesting?
% Difficult

% For instance, we could try to minimize the number of repeated notes
% At least this would give something random
repeated(N,T1;T2) :- melody(N,T1), melody(N,T2), T1!=T2.
repeated(N,T2) :- melody(N,T1), melody(N,T2), T1!=T2.
#minimize { 1,X,T : repeated(X,T) }.

% On top of this we may put some hard constraints

% Also adding silence as a note sounds good
