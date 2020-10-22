# Usage

All usage is explained as in interactive mode. CLI Mode is the same as interactive mode, except you must run as `PaperBuilder command_with_params`.

## Start PaperBuilder

### Windows

The installation adds an entry to the start menu. Simply search for `PaperBuilder` and click.

### Linux

The installation adds an alias to your `~/.bashrc` file. Simply running `pprb` in a bash terminal should be enough for most.

If you are using another terminal, add an alias to, or run `~/.PaperBuilder/PaperBuilder.py`.

### If you were too smart

Run the `PaperBuilder.py` from wherever it is installed.

## New project

In the interactive shell, run `new new_project_path`

This creates a folder `new_project_path` and 2 files in it, `content.md` and `bibliography.bib`.

`content.md` is where you put your content. Markdown syntax is already available in the file. Once you have read it, clear it and put your content. Add the metadata.

`bibliography.bib` is where all your references go in bibtex format. Almost all websites allow you to download citations in bibtex. Cite as [@citationname] in `content.md`. For example, [@einstein] will cite the bibtex entry with name `einstein`

## Build paper

This is where the magic happens.

In the interactive shell, run `pdf path_to_project`

And voila, if you've done everything correctly, you should have `content.pdf` in your project folder!

Incase you are unable to/ don't want to install latex, you can also use `latex path_to_project` which creates a latex file `content.tex` which you can compile online using Overleaf. This is also useful if you want to make some changes to the Latex file.

## Other Running options

These are not necessary for normal use. This is for debugging.

- `--help` - Display help
- `--debug` - Print debug info
- `--noop` - No operation mode. Use with `--debug` if no actions are to be taken
