type octave =
  | Octave0
  | Octave1
  | Octave2
  | Octave3
  | Octave4
  | Octave5
  | Octave6
  | Octave7
  | Octave8
  | Octave9
  | Octave10

type pitch =
  | C
  | Csharp
  | D
  | Dsharp
  | E
  | F
  | Fsharp
  | G
  | Gsharp
  | A
  | Asharp
  | B

type t = octave * pitch

val compare: t -> t -> int

val to_midi_int: t -> int