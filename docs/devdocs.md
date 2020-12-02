# Contributing

When contributing to this repository, please first discuss the change you wish to make via an issue with the maintainers of this repository before making a change.

## Where can I find the open issues?

See the issues tab in the [GitHub repo](https://github.com/IISERM/PaperBuilder).
If you wanna add a feature that isn't there already, make a new issue.

## What is this mess of a project?

It isn't THAT messy. Fine it is a little messy, but I'm doing all the work alone anyway 😤

```
PaperBuilder
├───docs            # This is where the website resides
│   └───test        # This should reflect latest release
├───linux           # Template installer script. Actual one built by dist.ps1
├───prereq          # pandoc.msi
├───src             # Main PaperBuilder script and init md and bib templates
│   └───default     # The templates
├───windows         # windows nsis build tools and running .bat file template
├───maketests.ps1   # builds the examples
└───dist.ps1        # creates a release distribution
```

## Ok, how do I add my feature?

1. Clone the repo (surprise surprise)
2. Change PaperBuilder.py and the templates. Be sure to change all the templates, the tex ones AND the .md and .bib files
3. Test it by manually installing pandoc and Latex distro(MikTex on Win and texlive on linux)
   - You can install the linux deps by reading the `.../linux/install.sh` file and running the appropriate commands
4. Build the docs/test and make sure things look ok
5. Send a PR, and explain your changes

## How TF do I build this?

Well... It's KIND of easy...Building only works on Windows rn, because that is my OS.

### Setup

1. Install MSVC BuildTools. Install the default C++ options. [See this](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019)
2. Install Python3.7.x [See Here](https://www.python.org/downloads/release/python-379/)
3. Install nuitka via pip [See this](https://nuitka.net/doc/user-manual.html#install-nuitka)
4. Install clcache if you want [See this](https://nuitka.net/doc/user-manual.html#caching-compilation-results)
5. Install nsis [See this](https://nsis.sourceforge.io/Main_Page)
6. Add the EnVar plugin for nsis [See this](https://nsis.sourceforge.io/EnVar_plug-in)

### Building

1. Activate the x64 version of the build tools in a powershell windows [See this](https://gist.github.com/DhruvaSambrani/d9f6e6ec617b43f5e1fd60900f89c919)
2. Run `...\dist.ps1`. This adds an untracked `release` folder.
3. Check if `...\release\PaperBuilder-Setup.exe` works
4. In a linux os, run `...\linux\install_local.sh` and see if everything works
