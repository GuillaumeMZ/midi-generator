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

type note =
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

let to_midi_int (octave, note) =
  let int_of_octave = function
    | Octave0 -> 0
    | Octave1 -> 1
    | Octave2 -> 2
    | Octave3 -> 3
    | Octave4 -> 4
    | Octave5 -> 5
    | Octave6 -> 6
    | Octave7 -> 7
    | Octave8 -> 8
    | Octave9 -> 9
    | Octave10 -> 10
  in
  let int_of_note = function
    | C -> 0
    | Csharp -> 1
    | D -> 2
    | Dsharp -> 3
    | E -> 4
    | F -> 5
    | Fsharp -> 6
    | G -> 7
    | Gsharp -> 8
    | A -> 9
    | Asharp -> 10
    | B -> 11
  in
  let octave_int = int_of_octave octave in
  let note_int   = int_of_note note in
  let result     = 12 * octave_int + note_int in
  if result > 127 then failwith "Invalid MIDI note" else result (* TODO: better error message *) 