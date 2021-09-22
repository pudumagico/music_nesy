% Modified from:
% Using answer set programming to detect and compose
% music in the structure of twelve bar blues

count(C) :- C = { note(N) }.
%% maj scales
%                W, W, H, W, W, W, H
scale(c ,maj,(c ;d ;e ;f ;g ;a ;b)).
scale(cs,maj,(cs;ds;f ;fs;gs;as;c)).
scale(d ,maj,(d ;e ;fs;g ;a ;b ;cs)).
scale(ds,maj,(ds;f ;g ;gs;as;c ;d)).
scale(e ,maj,(e ;fs;gs;a ;b ;cs;ds)).
scale(f ,maj,(f ;g ;a ;as;c ;d ;e)).
scale(fs,maj,(fs;gs;as;b ;cs;ds;f)).
scale(g ,maj,(g ;a ;b ;c ;d ;e ;fs)).
scale(gs,maj,(gs;as;c ;cs;ds;f ;g)).
scale(a ,maj,(a ;b ;cs;d ;e ;fs;gs)).
scale(as,maj,(as;c ;d ;ds;f ;g ;a)).
scale(b ,maj,(b ;cs;ds;e ;fs;gs;as)).
%% min scales
%                W, H, W, W, H, W, W
scale(a ,min,(a ;b ;c ;d ;e ;f ;g)).
scale(as,min,(as;c ;cs;ds;f ;fs;gs)).
scale(b ,min,(b ;cs;d ;e ;fs;g ;a)).
scale(c ,min,(c ;d ;ds;f ;g ;gs;as)).
scale(cs,min,(cs;ds;e ;fs;gs;a ;b)).
scale(d ,min,(d ;e ;f ;g ;a ;as;c)).
scale(ds,min,(ds;f ;fs;gs;as;b ;cs)).
scale(e ,min,(e ;fs;g ;a ;b ;c ;d)).
scale(f ,min,(f ;g ;gs;as;c ;cs;ds)).
scale(fs,min,(fs;gs;a ;b ;cs;d ;e)).
scale(g ,min,(g ;a ;as;c ;d ;ds;f)).
scale(gs,min,(gs;as;b ;cs;ds;e ;fs)).

%% Calculate all subsets of size C for each scale
C { guess(F,M,N) : scale(F,M,N) } C :- count(C).
%% Discard guesses not having the given notes
:- not guess(_,_,N), note(N).
%% Not allowed to have two guesses with different fundamentals and different notes
:- guess(F1,_,N1), guess(F2,_,N2), F1 != F2, N1 != N2.
%% Discard the subsets pointing to opposite modes
:- scale(F,M1), scale(F,M2), M1!=M2.
%% Get the scale
scale(F,M) :- guess(F,M,_).
notes(N) :- scale(F,M), scale(F,M,N).
% notes(silence).
