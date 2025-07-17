let () =
  let note_on = Event.NoteOn {channel = 0; note = (Note.Octave5, Note.C); velocity = 64} in
  let note_off = Event.NoteOff {channel = 0; note = (Note.Octave5, Note.C)} in
  let track = Track.empty () in
  let track' = Track.append_event note_on 0 track in
  let track'' = Track.append_event note_off 0x0C track' in
  let midi = Midi.empty () in
  let midi' = Midi.append_track track'' midi in
  let bytes = Midi.to_bytes midi' in
  let final_bytes = Bytes2.to_bytes bytes in
  let channel = Out_channel.open_bin "result.mid" in
  Out_channel.output_bytes channel final_bytes