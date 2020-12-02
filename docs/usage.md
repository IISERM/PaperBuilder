# Usage

All usage is explained as in interactive mode. CLI Mode is the same as interactive mode, except you must run as `PaperBuilder command_with_params`.

## Open a Terminal

### Windows

1. Hit `Win-X` then `i`. This will open a powershell terminal. 
2. Run `cd ~\Documents` or some other location
3. Run `PaperBuilder --help`. This should print a help screen

### Linux - Default installation

1. Start a terminal
2. `cd ~/Documents` or some other location
3. Run `pprb --help`. This should print a help screen

### Non Standard installations

1. Start a terminal
2. `cd ~/Documents` or some other location
3. run the `\path\to\PaperBuilder.py --help`. This should print a help screen

## New project

Run `PaperBuilder new new_project_path`. Replace `PaperBuilder` with `pprb` for linux.

This creates a folder `new_project_path` in the cwd(`Documents` if you used the above location) and 2 files in it, `content.md` and `bibliography.bib`.

`content.md` is where you put your content. Markdown syntax is already available in the file. Once you have read it, clear it and put your content. Add the metadata.

`bibliography.bib` is where all your references go in bibtex format. Almost all websites allow you to download citations in bibtex. Cite as [@citationname] in `content.md`. For example, [@einstein] will cite the bibtex entry with name `einstein`

## Build paper

This is where the magic happens.

Run `PaperBuilder build_type path_to_project` where `build_type` is one of the types in the table below. Replace `PaperBuilder` with `pprb` for linux.

And voila, if you've done everything correctly, you should have `content.pdf` in your project folder!

Incase you are unable to/don't want to install latex, use the `ltx*` build types, which create a latex file `content.tex` which you can compile online using Overleaf. This is also useful if you want to make some changes to the Latex file directly.

| Build Type | Use Case                                                      |
| ---------- | ------------------------------------------------------------- |
| report     | An elaborate format for building talk reports/seminar reports |
| assign     | Simple format for assignments                                 |
| ltxreport  | LaTeX file for `report` format                                |
| ltxassign  | LaTeX file for `assign` format                                |
| pdf        | same as `report`                                              |
| latex      | same as `ltxreport`                                           |

See the [Examples](./examples) page for a sneak peak into how each format looks

## The --extra option

In some cases you may need to send extra arguments to pandoc. For these use the `--extra="Your args"` option. Pandoc arguments can be found [here](https://pandoc.org/MANUAL.html#options)
Be careful of double quoting and spaces.

Example: `PaperBuilder report test --extra="--pdf-engine=xelatex"`

### The default extras

For cases below, the default `--extra` is often enough. See [Examples](./examples) for a demo.

- Using unicode characters directly
- Adding a dark theme for code blocks
- Adding Bold SmallCaps characters (used in the title of `report`)

To use this, the following setup needs to be done

| OS      | Change                                                                         |
| ------- | ------------------------------------------------------------------------------ |
| Windows | In MikTex Console, go to Packages, search for `gyre` and install both results. |
| Linux   | Install `texlive-xetex` using apt                                              |

## Other Running options

These are not necessary for normal use. This is for debugging.

- `--help` - Display help. A minimal help to remind you what is what.
- `--debug` - Print debug info. Especially useful for choosing the correct extra args
- `--noop` - No operation mode. Use with `--debug` if no actions are to be taken
