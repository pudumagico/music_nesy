import madmom
import numpy as np
import clingo
from midiutil import MIDIFile
from note2midi import note_to_number
# proc = madmom.features.chords.CNNChordFeatureProcessor()
# feats = proc('tests/Backing Track C - Am - Dm - G (S.Soul) tempo 80.mp3')
# decode = madmom.features.chords.CRFChordRecognitionProcessor()
#
# decoded_feats = decode(feats).tolist()
#
# # select most common chords in the track
# chord_dict = {}
# for chord in decoded_feats:
#     if chord[2] not in chord_dict:
#         chord_dict[chord[2]] = chord[1] - chord[0]
#     else:
#         chord_dict[chord[2]] += chord[1] - chord[0]
#
# print(chord_dict)
#
# # simple criteria for this would be above 20 seconds
# treshold = 20
# chord_list = []
# for chord in chord_dict:
#     if chord_dict[chord] > treshold:
#         chord_list.append(chord)
#
# # a little bit more of parsing
# parsed_chords = []
# for chord in chord_list:
#     split = chord.lower().split(':')
#     parsed_chords.append((split[0], split[1]))
#
# print(parsed_chords)
parsed_chords = [('c', 'maj'), ('a', 'min'), ('g', 'maj'), ('d', 'min')]
ctl = clingo.Control()

ctl.load('chords.lp')
ctl.load('scales.lp')
ctl.load('melody.lp')
ctl.add('base', [], ' '.join(f'chord({t},{s}).' for t,s in parsed_chords))
ctl.add('base', [], '#show melody/2.')

ctl.ground(parts=[('base', [])])
solvehandle = ctl.solve(yield_=True)

model = solvehandle.model()

melody = []
for symbol in model.symbols(shown=True):
    # print(symbol, str(symbol.arguments[0]), str(symbol.arguments[1]))
    melody.append((str(symbol.arguments[0]), int(str(symbol.arguments[1]))))

melody.sort(key=lambda x:x[1])
print(melody)


parsed_melody = []
for note in melody:
    parsed_melody.append(note_to_number(note[0], 6))

print(parsed_melody)
#
# degrees  = [60, 62, 64, 65, 67, 69, 71, 72]  # MIDI note number
track    = 0
channel  = 0
time     = 0    # In beats
duration = 1    # In beats
tempo    = 80   # In BPM
volume   = 100  # 0-127, as per the MIDI standard

MyMIDI = MIDIFile(1)  # One track, defaults to format 1 (tempo track is created
                      # automatically)
MyMIDI.addTempo(track, time, tempo)

for i, pitch in enumerate(parsed_melody):
    MyMIDI.addNote(track, channel, pitch, time + i, duration, volume)

with open("major-scale.mid", "wb") as output_file:
    MyMIDI.writeFile(output_file)
