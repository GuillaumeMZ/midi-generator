type t = Track.t list

type format =
  | SingleTrack
  | MultiTrackSingleChannel
  | MultiTrackMultiChannel

let int_of_format = function
| SingleTrack -> 0
| MultiTrackSingleChannel -> 1
| MultiTrackMultiChannel -> 2 

let empty () = []

let append_track track midi = midi @ [track]

let to_bytes midi = 
  let midi_header_data_size = 6 in
     Bytes2.of_string "MThd"
  |> Bytes2.append_int32_be (Int32.of_int midi_header_data_size)
  |> Bytes2.append_int16_be 0 (* TODO: allow format selection *)
  |> Bytes2.append_int16_be (List.length midi)
  |> Bytes2.append_int16_be (0xC0) (* TODO: allow to change the ticks/quarter note (all bits except n°1 which is 1 = smpte, 0 = ticks/quarter note) *)
  |> Bytes2.append_list (List.map Track.to_bytes midi)