%% Major chords
% some notes are the same es = f, bs = c
note(c;e;g) :- chord(c,maj).
note(cs;es;gs) :- chord(cs,maj).
note(d;fs;a) :- chord(d,maj).
note(ds;g;as) :- chord(ds,maj).
note(e;gs;b) :- chord(e,maj).
note(f;a;c) :- chord(f,maj).
note(fs;as;cs) :- chord(fs,maj).
note(g;b;d) :- chord(g,maj).
note(gs;c;ds) :- chord(gs,maj).
note(a;cs;e) :- chord(a,maj).
note(as;d;f) :- chord(as,maj).
note(b;ds;fs) :- chord(b,maj).

%% Minor chords
note(c;ds;g) :- chord(c,min).
note(cs;e;gs) :- chord(cs,min).
note(d;f;a) :- chord(d,min).
note(ds;fs;as) :- chord(ds,min).
note(e;g;b) :- chord(e,min).
note(f;gs;c) :- chord(f,min).
note(fs;a;cs) :- chord(fs,min).
note(g;a;d) :- chord(g,min).
note(gs;b;ds) :- chord(gs,min).
note(a;c;e) :- chord(a,min).
note(as;cs;f) :- chord(as,min).
note(b;d;fs) :- chord(b,min).
