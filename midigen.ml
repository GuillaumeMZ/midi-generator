let usage_message = "midigen -i <input file> -o <output file>"
let input_file = ref ""
let output_file = ref ""

let speclist = [
  ("-i", Arg.Set_string input_file, "Set input file path");
  ("-o", Arg.Set_string output_file, "Set output file path")
]

let rec add_offs events = match events with
| [] -> []
| Event.NoteOn {channel; note; _} as hd :: tl -> hd :: (Event.NoteOff {channel; note;}) :: add_offs tl  
| hd :: tl -> hd :: add_offs tl

let () =
  Random.self_init ();
  Arg.parse speclist ignore usage_message;
  let config = Config.of_file !input_file in
  let notes = Config.NoteMarkov.run config.initial_note config.notes config.chain in
  let events = List.map (fun note -> Event.NoteOn {channel = 0; note; velocity = config.volume}) notes |> add_offs in
  let events' = (Event.ProgramChange {channel = 0; program = Instrument.to_midi_code config.instrument}) :: events @ [Event.EndOfTrack] in
  let track = List.fold_left (fun acc  event -> Track.append_event event config.tempo acc) (Track.empty ()) events' in
  let midi_bytes = Midi.empty () |> Midi.append_track track |> Midi.to_bytes |> Bytes2.to_bytes in
  let channel = Out_channel.open_bin !output_file in
  Out_channel.output_bytes channel midi_bytes