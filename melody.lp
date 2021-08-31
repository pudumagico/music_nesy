% #const notes_per_bar = 4.
#const bars = 4.

notes(silence).
values(4;2;1).
bar(4).

% time(1..M) :- M = notes_per_bar*bars.


1 { melody(T,N,V) : notes(N), values(V) } 8 :- bar(T).

% We need to fill the bar

:- S = #sum{ V : melody(T,N,V) }, S != 4.

% No same consecutives notes

:- melody(T,N,_), melody(T,N,_).

% No same consecutives values, just to mix it up a lil
% :- melody(T,_,V), melody(R,_,V).

% And there must be silence for spice
