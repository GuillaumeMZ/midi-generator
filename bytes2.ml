type t = Bytes.t

let empty () = Bytes.empty

let of_byte_list bytes = Bytes.init (List.length bytes) (fun i -> List.nth bytes i |> char_of_int)

let of_string = Bytes.of_string

let to_bytes = Fun.id

let append to_append stream =
  let length_stream = Bytes.length stream in
  let length_to_append = Bytes.length to_append in
  let new_stream = Bytes.extend stream 0 length_to_append in
  Bytes.blit to_append 0 new_stream length_stream length_to_append;
  new_stream

let rec append_list list stream =
  match list with
  | [] -> stream
  | hd :: tl -> begin
      let appended = append hd stream in
      append_list tl appended
    end

let append_int16_be i16 stream =
  let int16_stream = Bytes.create 2 in
  Bytes.set_int16_be int16_stream 0 i16;
  append int16_stream stream

let append_int32_be i32 stream =
  let i32_stream = Bytes.create 4 in
  Bytes.set_int32_be i32_stream 0 i32;
  append i32_stream stream

let length = Bytes.length 