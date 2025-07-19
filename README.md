# MIDI generator

This is a procedural music generator, which uses [Markov chains](https://en.wikipedia.org/wiki/Markov_chain) to generate coherent audio.

https://github.com/user-attachments/assets/77e3cdda-6ff8-4f75-a339-d0cd948e8e76

## Features

- Create the melody you want by providing a custom Markov chain; see the section "How to run" below.
- Use any instrument among 127 instruments available; see the section "Available instruments" below.
- Configure how long the music must be.
- Configure the music's tempo.
- Configure the volume.

## How to compile

- Download and install [Opam](https://opam.ocaml.org/) with your distribution's package manager.
- Install the OCaml compiler and [Dune](https://dune.build/) using Opam:

    ```bash
    opam install ocaml
    opam install dune
    ```

- Clone this repository and open a terminal inside the root folder
- Build the project:

    ```bash
    dune build --profile release
    ```

The generated executable (`midigen.exe`) is located in the `_build/default` folder.

Note: even though the executable has the `.exe` extension on Linux/MacOS, it is still a native executable.

## How to run

Start `midigen.exe -i path_to_config_file -o path/to/result.mid`. You can use the configuration file provided in the `example_input` folder to test the program. Here is a small guide about the expected file format:

- The first line must be `instrument: instrument_name` where `instrument_name` is one of the instruments defined in the "Available instruments" section.
- The second line must be `notes: number_of_notes` where `number_of_notes` is the number of notes of the output.
- The third line must be `tempo: the_tempo` where `the_tempo` (between 0 and 127 included) controls how fast the output music will be.
- The fourth line must be `volume: the_volume` where `the_volume` (between 0 and 127 included) controls the volume of the output music.
- The fifth line must be `initial: initial_note` where `initial_note` will be the first note of the output music.
- These five lines are followed by Markov chain transitions, one per line. For instance, the transition `C 5 -> D 5 (0.5)` means "there is a 0.5 probability that the next note is D (octave 5) if the current note is C (octave 5).

To listen to the result, install a MIDI player such as [Timidity](https://sourceforge.net/projects/timidity/). If you use Timidity, just run (assuming it is in your `$PATH`)

```bash
timidity path/to/result.mid
```

to play the generated sound.

## Available instruments

### Piano timbres

- `acoustic_grand_piano`
- `bright_acoustic_piano`
- `electric_grand_piano`
- `honky-tonk_piano`
- `rhodes_piano`
- `chorused_piano`
- `harpsichord`
- `clavinet`

### Chromatic percussion

- `celesta`
- `glockenspiel`
- `music_box`
- `vibraphone`
- `marimba`
- `xylophone`
- `tubular_bells`
- `dulcimer`

### Organ timbres

- `hammond_organ`
- `percussive_organ`
- `rock_organ`
- `church_organ`
- `reed_organ`
- `accordion`
- `harmonica`
- `tango_accordion`

### Guitar timbres

- `acoustic_nylon_guitar`
- `acoustic_steel_guitar`
- `electric_jazz_guitar`
- `electric_clean_guitar`
- `electric_muted_guitar`
- `overdriven_guitar`
- `distortion_guitar`
- `guitar_harmonics`

### Bass timbres

- `acoustic_bass`
- `fingered_electric_bass`
- `plucked_electric_bass`
- `fretless_bass`
- `slap_bass_1`
- `slap_bass_2`
- `synth_bass_1`
- `synth_bass_2`

### String timbres

- `violin`
- `viola`
- `cello`
- `contrabass`
- `tremolo_strings`
- `pizzicato_strings`
- `orchestral_harp`
- `timpani`

### Ensemble timbres

- `string_ensemble_1`
- `string_ensemble_2`
- `synth_strings_1`
- `synth_strings_2`
- `choir_aah`
- `choir_ooh`
- `synth_voice`
- `orchestra_hit`

### Brass timbres

- `trumpet`
- `trombone`
- `tuba`
- `muted_trumpet`
- `french_horn`
- `brass_section`
- `synth_brass_1`
- `synth_brass_2`

### Reed timbres

- `soprano_sax`
- `alto_sax`
- `tenor_sax`
- `baritone_sax`
- `oboe`
- `english_horn`
- `bassoon`
- `clarinet`

### Pipe timbres

- `piccolo`
- `flute`
- `recorder`
- `pan_flute`
- `bottle_blow`
- `shakuhachi`
- `whistle`
- `ocarina`

### Synth lead

- `square_wave_lead`
- `sawtooth_wave_lead`
- `calliope_lead`
- `chiff_lead`
- `charang_lead`
- `voice_lead`
- `fifths_lead`
- `bass_lead`

### Synth pad

- `new_age_pad`
- `warm_pad`
- `polysynth_pad`
- `choir_pad`
- `bowed_pad`
- `metallic_pad`
- `halo_pad`
- `sweep_pad`

### Synth effects

- `rain_effect`
- `soundtrack_effect`
- `crystal_effect`
- `atmosphere_effect`
- `brightness_effect`
- `goblins_effect`
- `echoes_effect`
- `sci-fi_effect`

### Ethnic timbres

- `sitar`
- `banjo`
- `shamisen`
- `koto`
- `kalimba`
- `bag_pipe`
- `fiddle`
- `shanai`

### Sound effects

- `tinkle_bell`
- `agogo`
- `steel_drums`
- `woodblock`
- `taiko_drum`
- `melodic_tom`
- `synth_drum`
- `reverse_cymbal`
- `guitar_fret_noise`
- `breath_noise`
- `seashore`
- `bird_tweet`
- `telephone_ring`
- `helicopter`
- `applause`
- `gunshot`

## Resources

- [MIDI technical specification](http://www.somascape.org/midi/tech/mfile.html)
- [MIDI files explained](https://www.youtube.com/watch?v=P27ml4M3V7A) (YouTube video)
- [Standard MIDI File Format](https://faydoc.tripod.com/formats/mid.htm)
- [MIDI Programming - a complete study (part 1)](http://www.petesqbsite.com/sections/express/issue18/midifilespart1.html)
- [General MIDI](https://en.wikipedia.org/wiki/General_MIDI) (contains the list of instruments)
- [MIDI meta messages](https://www.recordingblogs.com/wiki/midi-meta-messages)
- [Variable-length quantity](https://github.com/kstenerud/vlq/blob/master/vlq-specification.md)
