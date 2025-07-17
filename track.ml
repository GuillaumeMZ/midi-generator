type t = Bytes2.t

let empty = Bytes2.empty

let append_event event delta track =
  assert (delta <= 255); (* TODO: implement vfq and remove this assert. *)

  let base_bytes   = Bytes2.of_byte_list [delta] in
  let event_bytes  = Event.to_bytes event in
  let result_bytes = Bytes2.append event_bytes base_bytes in
  Bytes2.append result_bytes track

let to_bytes track = 
     Bytes2.of_string "MTrk"
  |> Bytes2.append_int32_be (Bytes2.length track |> Int32.of_int)
  |> Bytes2.append track