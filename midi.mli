(** The type representing a MIDI file. *)
type t

(** The type representing the format of a MIDI file. *)
type format =
  | SingleTrack
  | MultiTrackSingleChannel
  | MultiTrackMultiChannel

(** Returns the MIDI identifier of a MIDI format. *)
val int_of_format: format -> int

(** [empty ()] creates an empty MIDI file. *)
val empty: unit -> t

(** [append_track t m] adds a track t to a MIDI file m, then returns the new MIDI file. *)
val append_track: Track.t -> t -> t

(** [to_bytes m] creates the byte stream corresponding to the contents of [m]. *)
val to_bytes: t -> Bytes2.t