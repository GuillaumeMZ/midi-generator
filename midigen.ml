let () =
  Random.self_init ();
  let note_on = Event.NoteOn {channel = 0; note = (Note.Octave5, Note.C); velocity = 64} in
  let note_off = Event.NoteOff {channel = 0; note = (Note.Octave5, Note.C)} in
  let end_of_track = Event.EndOfTrack in
  let track = 
       Track.empty ()
    |> Track.append_event note_on 0
    |> Track.append_event note_off 0x0C
    |> Track.append_event end_of_track 0 in
  let midi_bytes = 
       Midi.empty ()
    |> Midi.append_track track
    |> Midi.to_bytes
    |> Bytes2.to_bytes in
  let channel = Out_channel.open_bin "result.mid" in
  Out_channel.output_bytes channel midi_bytes