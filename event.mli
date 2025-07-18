(** The type representing a MIDI event. *)
type t =
  | NoteOn of {channel: int; note: Note.t; velocity: int}
  | NoteOff of {channel: int; note: Note.t}
  | EndOfTrack

(** [to_bytes event] returns [event]'s byte representation. *)
val to_bytes: t -> Bytes2.t