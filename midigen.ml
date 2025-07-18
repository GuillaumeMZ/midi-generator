open Note

module StringMarkov = Markov.Make(String)

let markov =
       StringMarkov.empty
    |> StringMarkov.add_node "C" (Octave5, C)
    |> StringMarkov.add_node "D" (Octave5, D)
    |> StringMarkov.add_node "E" (Octave5, E)
    |> StringMarkov.add_node "F" (Octave5, F)
    |> StringMarkov.add_node "G" (Octave5, G)
    |> StringMarkov.add_node "A" (Octave5, A)
    |> StringMarkov.add_node "B" (Octave5, B)
    |> StringMarkov.add_transition "C" "C" 0.2
    |> StringMarkov.add_transition "C" "D" 0.8
    |> StringMarkov.add_transition "D" "C" 0.45
    |> StringMarkov.add_transition "D" "D" 0.1
    |> StringMarkov.add_transition "D" "E" 0.45
    |> StringMarkov.add_transition "E" "D" 0.45
    |> StringMarkov.add_transition "E" "E" 0.1
    |> StringMarkov.add_transition "E" "F" 0.45
    |> StringMarkov.add_transition "F" "E" 0.45
    |> StringMarkov.add_transition "F" "F" 0.1
    |> StringMarkov.add_transition "F" "G" 0.45
    |> StringMarkov.add_transition "G" "F" 0.45
    |> StringMarkov.add_transition "G" "G" 0.1
    |> StringMarkov.add_transition "G" "A" 0.45
    |> StringMarkov.add_transition "A" "G" 0.45
    |> StringMarkov.add_transition "A" "A" 0.1
    |> StringMarkov.add_transition "A" "B" 0.45
    |> StringMarkov.add_transition "B" "A" 0.8
    |> StringMarkov.add_transition "B" "B" 0.2

let rec add_offs events = match events with
| [] -> []
| Event.NoteOn {channel; note; _} as hd :: tl -> hd :: (Event.NoteOff {channel; note;}) :: add_offs tl  
| hd :: tl -> hd :: add_offs tl

let () =
  Random.self_init ();
  let notes = StringMarkov.run "C" 30 markov in
  let events = List.map (fun note -> Event.NoteOn {channel = 0; note; velocity = 64}) notes |> add_offs in
  let events' = events @ [Event.EndOfTrack] in
  let track = List.fold_left (fun acc  event -> Track.append_event event 80 acc) (Track.empty ()) events' in
  let midi_bytes = Midi.empty () |> Midi.append_track track |> Midi.to_bytes |> Bytes2.to_bytes in
  let channel = Out_channel.open_bin "result.mid" in
  Out_channel.output_bytes channel midi_bytes