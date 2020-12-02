# Installation

[Uninstall](#uninstallation) the previous version, if any

## Windows

Go to the [latest release](https://github.com/IISERM/PaperBuilder/releases/latest) and download `PaperBuilder-Setup.exe`. Run it. You can basically click through without much thought or changes. It will install PaperBuilder and Pandoc. It will also link you to MikTex installation.

## Linux-Ubuntu

Go to the [latest release](https://github.com/IISERM/PaperBuilder/releases/latest) and download `PaperBuilder-Setup.sh`. Run `bash PaperBuilder-Setup.sh` to install all dependencies (pandoc, texlive, python).

## I'm too smart for installers

1. Install python3.7+, a latex compiler, and pandoc. Add all to path.
2. Go to [latest release](https://github.com/IISERM/PaperBuilder/releases/latest) and download any of the `source-files` archive.
3. Extract to a folder of your choice. Add folder to PATH.
4. Run as `PaperBuilder.py --help`

# Uninstallation

## Windows

Either uninstall from the Control Panel, Settings, or run `PaperBuilder uninstall`. This will NOT uninstall MikTex

## Linux-Ubuntu

Run the following:

1. `rm -rf ~/.paperbuilder`
2. `sudo apt autoremove texlive-latex-extra pandoc`
3. Edit `~/.bashrc` to remove the `pprb` alias

## Non Standard installation

1. Remove the extracted folder
2. Uninstall Python3.7, the latex compiler and pandoc
3. Also remove paths from PATH.
