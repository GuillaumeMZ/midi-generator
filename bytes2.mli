(** A functional (as in non-mutable) "replacement" for the Bytes module. *)

(** The type representing a byte stream. *)
type t

(** [empty ()] creates a new, empty byte stream. *)
val empty: unit -> t

(** [of_byte_list l] creates a new byte stream equal to l. Each number in l must be >= 0 && <= 255, otherwise the function fails. *)
val of_byte_list: int list -> t

(** [of_string] creates a new byte stream with each byte corresponding to the ASCII value of the corresponding character. *)
val of_string: string -> t

(** [to_bytes stream] converts [stream], a Byte2 byte stream, into a Bytes byte stream. *)
val to_bytes: t -> Bytes.t

(** [append to_append stream] appends the byte stream [to_append] to the byte stream [stream], then returns the result. *)
val append: t -> t -> t

(** [append list stream] appends each stream contained in [list] to [stream], in order. *)
val append_list: t list -> t -> t

(** [append_int16_be i16 stream] appends [i16] in big-endian to [stream]. *)
val append_int16_be: int -> t -> t

(** [append_int32_be i32 stream] appends [i32] in big-endian to [stream]. *)
val append_int32_be: int32 -> t -> t

(** [length stream] returns the number of bytes contained in [stream]. *)
val length: t -> int