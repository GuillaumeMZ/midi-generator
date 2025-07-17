(** The type representing a MIDI event. *)
type t =
  | NoteOn of {channel: int; note: Note.octave * Note.note; velocity: int}
  | NoteOff of {channel: int; note: Note.octave * Note.note}

(** [to_bytes event] returns [event]'s byte representation. *)
val to_bytes: t -> Bytes2.t