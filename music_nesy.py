import madmom
import numpy as np
import clingo

# print(madmom.__dict__)
proc = madmom.features.chords.CNNChordFeatureProcessor()
feats = proc('tests/Backing Track C - Am - Dm - G (S.Soul) tempo 80.mp3')
print(feats)
decode = madmom.features.chords.CRFChordRecognitionProcessor()
print(decode(feats))
