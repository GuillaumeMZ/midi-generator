(** The type representing a MIDI track. *)
type t

(** [empty ()] creates an empty track. *)
val empty: unit -> t

(** [append_event e delta t] adds an event e to a track t (with a delta time [delta]), then returns the new track. *)
val append_event: Event.t -> int -> t -> t

(** [to_bytes track] creates a byte stream corresponding to [track]. *)
val to_bytes: t -> Bytes2.t