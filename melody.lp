% We have all the notes
% We can produce simple melodies for a set number of bars
% Of course, the beat will be set to 4/4 for simplicity
notes(c).
notes(d).
notes(e).
notes(f).
notes(g).
notes(a).
notes(b).


bars(1..12).
% If we have 12 bars, and 4 whites notes, then that is 48 notes in total.
time(1..48).
{melody(N,T) : notes(N)} = 1:- time(T).

% Now this is the tricky part
% How to make constraints or optimizations
% so the produced melody is actually interesting?
% Difficult

% For instance, we could try to minimize the number of repeated notes
% At least this would give something random
% repeated(N,T1) :- melody(N,T1), melody(N,T2), T1!=T2.
% repeated(N,T2) :- melody(N,T1), melody(N,T2), T1!=T2.
%
% #minimize { 1,X,T : repeated(X,T) }.
:~ melody(N,T1), melody(N,T2), T1!=T2. [1]
% On top of this we may put some hard constraints

% Also adding silence as a note sounds good

#show melody/2.
