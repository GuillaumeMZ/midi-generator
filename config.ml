module NoteMarkov = Markov.Make(Note)

type t = {
  initial_note: Note.t;
  instrument: Instrument.t;
  notes: int;
  tempo: int;
  volume: int;
  chain: Note.t NoteMarkov.t
}

let of_file file_path =
  let note_markov_of_strings strings =
    List.fold_left (fun acc string ->
      let (pitch_source, octave_source, pitch_dest, octave_dest, weight) = Scanf.sscanf string "%s %s -> %s %s (%f)" (fun a b c d e -> (a, b, c, d, e)) in
      let source_note = Note.of_string (pitch_source ^ " " ^ octave_source) in
      let dest_note = Note.of_string (pitch_dest ^ " " ^ octave_dest) in
      acc
      |> NoteMarkov.add_node source_note source_note
      |> NoteMarkov.add_node dest_note dest_note
      |> NoteMarkov.add_transition source_note dest_note weight
    ) NoteMarkov.empty strings
  in
  let of_string_list strings =
    let instrument   = Scanf.sscanf (List.nth strings 0) "instrument: %s" (fun instrument -> Instrument.of_string instrument) in
    let notes        = Scanf.sscanf (List.nth strings 1) "notes: %d" Fun.id in
    let tempo        = Scanf.sscanf (List.nth strings 2) "tempo: %d" Fun.id in
    let volume       = Scanf.sscanf (List.nth strings 3) "volume: %d" Fun.id in
    let initial_note = Scanf.sscanf (List.nth strings 4) "initial: %s %s" (fun pitch octave -> Note.of_string (pitch ^ " " ^ octave)) in
    let chain        = List.drop 5 strings |> note_markov_of_strings in
    {initial_note; instrument; notes; tempo; volume; chain}
  in
  let in_channel = In_channel.open_text file_path in
  In_channel.input_lines in_channel |> of_string_list