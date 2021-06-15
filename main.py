import sys

import madmom
import clingo
import numpy as np

from midiutil import MIDIFile
from note2midi import note_to_number

def get_chords(file_path):

    proc = madmom.features.chords.CNNChordFeatureProcessor()
    feats = proc(file_path)
    decode = madmom.features.chords.CRFChordRecognitionProcessor()

    decoded_feats = decode(feats).tolist()

    chord_dict = {}
    total_length = 0
    for chord in decoded_feats:
        if chord[2] not in chord_dict:
            chord_dict[chord[2]] = chord[1] - chord[0]
            total_length += chord[1] - chord[0]
        else:
            chord_dict[chord[2]] += chord[1] - chord[0]
            total_length += chord[1] - chord[0]

    treshold = total_length * 0.1
    chord_list = []
    for chord in chord_dict:
        if chord_dict[chord] > treshold:
            chord_list.append(chord)

    parsed_chords = []
    for chord in chord_list:
        split = chord.lower().split(':')
        parsed_chords.append((split[0], split[1]))

    print(f"parsed_chords={parsed_chords}")

    return parsed_chords

def reason_melody(chords, style = None):
    ctl = clingo.Control()

    ctl.load('chords.lp')
    ctl.load('scales.lp')
    ctl.load('melody.lp')
    ctl.add('base', [], ' '.join(f'chord({t},{s}).' for t,s in chords))
    ctl.add('base', [], '#show melody/2. #show scale/2. #show note/1.')
    if style:
        ctl.load(style)

    ctl.ground(parts=[('base', [])])
    solvehandle = ctl.solve(yield_=True)
    for m in solvehandle:
        model = m

    melody = []
    for symbol in model.symbols(shown=True):
        if 'melody' in str(symbol):
            melody.append((str(symbol.arguments[0]), int(str(symbol.arguments[1]))))

    melody.sort(key=lambda x:x[1])

    parsed_melody = []
    for note in melody:
        parsed_melody.append(note_to_number(note[0], 6))

    print(f"parsed_melody={parsed_melody}")

    return parsed_melody

def melody_to_midi(melody, output):
    track    = 0
    channel  = 0
    time     = 0    # In beats
    duration = 1    # In beats
    tempo    = 80   # In BPM
    volume   = 100  # 0-127, as per the MIDI standard

    MyMIDI = MIDIFile(1)  # One track, defaults to format 1 (tempo track is created
                          # automatically)
    MyMIDI.addTempo(track, time, tempo)

    for i, pitch in enumerate(melody):
        MyMIDI.addNote(track, channel, pitch, time + i, duration, volume)

    with open('melodies/' + output + '.mid', "wb") as output_file:
        MyMIDI.writeFile(output_file)

def main(file_path):
    #read entry file and produce chords
    chords = get_chords(file_path)
    #use the chords in clingo
    melody = reason_melody(chords)
    #produce a midi
    melody_to_midi(melody, file_path.split('/')[-1])
    #optionally, we may conver midi to wav/flac/mp3 and merge the files togheter
    #TODO

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print('Usage: python main.py tracks/Cmaj-Amin.mp3')
        exit(0)

    main(sys.argv[1])
