type t =
  | NoteOn of {channel: int; note: Note.t; velocity: int}
  | NoteOff of {channel: int; note: Note.t}
  | EndOfTrack

let note_on_event_code  = 9
let note_off_event_code = 8

let note_on_to_bytes channel note velocity =
  assert (channel <= 15); (* TODO: better error handling *)
  assert (velocity <= 127); (* ditto *)

  let status = (note_on_event_code lsl 4) lor channel in
  let note_code = Note.to_midi_int note in
  Bytes2.of_byte_list [status; note_code; velocity]

let note_off_to_bytes channel note =
  assert (channel <= 15);
  
  let status = (note_off_event_code lsl 4) lor channel in
  let note_code = Note.to_midi_int note in
  Bytes2.of_byte_list [status; note_code; 0 (* velocity *)]

let end_of_track_to_bytes = Bytes2.of_byte_list [0xFF; 0x2F; 0x00]

let to_bytes = function
  | NoteOn {channel; note; velocity} -> note_on_to_bytes channel note velocity
  | NoteOff {channel; note} -> note_off_to_bytes channel note
  | EndOfTrack -> end_of_track_to_bytes