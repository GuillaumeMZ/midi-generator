(** The type representing an instrument. *)
type t

(** [of_string s] converts a string to an instrument. Fails if the instrument is unknown. See README.md to find a list of all the instruments. *)
val of_string: string -> t

(** [to_midi_code i] returns the MIDI code of the instrument. *)
val to_midi_code: t -> int