%% Major chords
% some notes are the same es = f, bs = c
3{note(c); note(e); note(g)}3 :- chord(c,maj).
3{note(cs); note(es); note(gs)}3 :- chord(cs,maj).
3{note(d); note(fs); note(a)}3 :- chord(d,maj).
3{note(ds); note(g); note(as)}3 :- chord(ds,maj).
3{note(e); note(gs); note(b)}3 :- chord(e,maj).
3{note(f); note(a); note(c)}3 :- chord(f,maj).
3{note(fs); note(as); note(cs)}3 :- chord(fs,maj).
3{note(g); note(b); note(d)}3 :- chord(g,maj).
3{note(gs); note(c); note(ds)}3 :- chord(gs,maj).
3{note(a); note(cs); note(e)}3 :- chord(a,maj).
3{note(as); note(d); note(f)}3 :- chord(as,maj).
3{note(b); note(ds); note(fs)}3 :- chord(b,maj).

%% Minor chords
3{note(c); note(ds); note(g)}3 :- chord(c,min).
3{note(cs); note(e); note(gs)}3 :- chord(cs,min).
3{note(d); note(f); note(a)}3 :- chord(d,min).
3{note(ds); note(fs); note(as)}3 :- chord(ds,min).
3{note(e); note(g); note(b)}3 :- chord(e,min).
3{note(f); note(gs); note(c)}3 :- chord(f,min).
3{note(fs); note(a); note(cs)}3 :- chord(fs,min).
3{note(g); note(a); note(d)}3 :- chord(g,min).
3{note(gs); note(b); note(ds)}3 :- chord(gs,min).
3{note(a); note(c); note(e)}3 :- chord(a,min).
3{note(as); note(cs); note(f)}3 :- chord(as,min).
3{note(b); note(d); note(fs)}3 :- chord(b,min).
