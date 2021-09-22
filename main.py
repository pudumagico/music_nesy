import sys
import random

import madmom
import clingo
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

    threshold = total_length * 0.2
    chord_list = []
    for chord in chord_dict:
        if chord_dict[chord] > threshold:
            chord_list.append(chord)

    print(chord_list)

    parsed_chords = []
    for chord in chord_list:
        split = chord.lower().split(':')
        parsed_chords.append((split[0].replace('#', 's'), split[1]))

    print(f"parsed_chords={parsed_chords}")

    return parsed_chords


def reason_melody(chords, style=None):
    ctl = clingo.Control()

    ctl.load('chords.lp')
    ctl.load('scales.lp')
    ctl.load('melody.lp')
    ctl.add('base', [], ' '.join(f'chord({t},{s}).' for t, s in chords))

    ctl.add('base', [], '#show melody/4 . #show scale/2. #show notes/1.')
    if style:
        ctl.load(style)

    ctl.ground(parts=[('base', [])])
    solvehandle = ctl.solve(yield_=True)
    models = []
    for m in solvehandle:
        models.append(m)

    print('len', len(models))
    model = random.choice(models)

    melody = []
    for symbol in model.symbols(shown=True):
        print(str(symbol))
        if 'melody' in str(symbol):
            melody.append(
                ( int(str(symbol.arguments[0])), int(str(symbol.arguments[1])), str(symbol.arguments[2]), int(str(symbol.arguments[3]))))


    melody.sort(key=lambda x: x[0])
    print(melody)

    return melody


def melody_to_midi(melody, output):

    parsed_melody = []
    for note in melody:
        parsed_melody.append((note_to_number(note[2], 6), note[0], note[1], note[3]))

    print(f"parsed_melody={parsed_melody}")

    track = 0
    channel = 0
    time = 0  # In beats
    # duration = 1  # In beats
    tempo = 80  # In BPM
    volume = 100  # 0-127, as per the MIDI standard

    # One track, defaults to format 1 (tempo track is created
    # automatically)
    my_midi = MIDIFile(1)
    my_midi.addTempo(track, time, tempo)

    for note, bar, timeslot, value in parsed_melody:
        print(note, bar, timeslot, value)
        my_midi.addNote(
            track, channel, note, time + (bar-1)*8 + int(timeslot), value / 8, volume)

    with open(output + '.mid', "wb") as output_file:
        my_midi.writeFile(output_file)


def main(file_path):
    # read entry file and produce chords
    chords = get_chords(file_path)
    # use the chords in clingo
    melody = reason_melody(chords)
    # produce a midi
    melody_to_midi(melody, file_path)
    # optionally, we may convert midi to wav/flac/mp3 and merge the files together
    # TODO


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print('Usage: python main.py Cmaj-Amin.mp3')
        exit(0)

    main(sys.argv[1])
