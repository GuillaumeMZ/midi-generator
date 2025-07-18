# MIDI generator

This is a procedural music generator, which uses [Markov chains](https://en.wikipedia.org/wiki/Markov_chain) to generate coherent audio.

![Video](example/file.mp4)

## Features

- Generate a ~30s long piano sequence using the C major scale.

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

Just start `midigen.exe`. It will produce a MIDI file named `result.mid` in the current working directory. To listen to the result, install a MIDI player such as [Timidity](https://sourceforge.net/projects/timidity/). If you use Timidity, just run (assuming it is in your `$PATH`)

```bash
timidity path/to/result.mid
```

to play the generated sound.

## Resources

- [MIDI technical specification](http://www.somascape.org/midi/tech/mfile.html)
- [MIDI files explained](https://www.youtube.com/watch?v=P27ml4M3V7A) (YouTube video)
- [Standard MIDI File Format](https://faydoc.tripod.com/formats/mid.htm)
- [MIDI Programming - a complete study (part 1)](http://www.petesqbsite.com/sections/express/issue18/midifilespart1.html)
- [General MIDI](https://en.wikipedia.org/wiki/General_MIDI) (contains the list of instruments)
- [MIDI meta messages](https://www.recordingblogs.com/wiki/midi-meta-messages)
- [Variable-length quantity](https://github.com/kstenerud/vlq/blob/master/vlq-specification.md)
