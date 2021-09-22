notes(d).
notes(e).
notes(g).
notes(a).
notes(b).
notes(cs).
notes(fs).

notes(silence).

#const bars = 2.
#const bar_length = 8.

bar(1..bars).
values(1).

timeslot(B, 1..T) :- bar(B), T = bar_length.

0 { melody(B,T,N,V) : notes(N), values(V) } 1 :- timeslot(B, T).

occupied(B,N,T..T+V-1) :- melody(B,T,N,V).

:- S = #sum{ V,T,N : melody(B,T,N,V) }, bar(B), S !=8.

:- occupied(B,N1,T), occupied(B,N2,T), N1 != N2.

:- melody(B,T1,N,_), melody(B,T2,N,_), T1 != T2.

:- occupied(B,N,T), T > 8.

#show melody/4.
#show occupied/3.