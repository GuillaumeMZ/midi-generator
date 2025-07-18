(** Represents the octave of a note. *)
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

(** Represents the pitch of a note. *)
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

(** [compare a b] compares two notes [a] and [b]. *)
val compare: t -> t -> int

(** [to_midi_int note] converts a note into its MIDI representation.*)
val to_midi_int: t -> int

(** [of_string string] converts a string into the corresponding note. Raises an exception if the string is incorrect.*)
val of_string: string -> t