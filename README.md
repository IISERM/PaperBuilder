# PaperBuilder
Build a latex paper with IISER Mohali logo and superb formatting with just Markdown

## WOW! SUCH A SUPERB TEMPLATE! WHO MADE IT?

Mayukh Chakrabarty of MS18 made this template, all credits to him.

Tailoring it to use with pandoc was done by Dhruva Sambrani

## WTF is markdown? Why can't I just directly use Latex?

Markdown is a very simplistic markup language. Much like html, but WAAAAY easier.
Want to add a heading? No big deal! Just do `# h1` or `## h2` or ... Want to add that lovely plot you made? Do `![Image caption](image path)`. A link? `[Link caption](url)`. But what about MATH? Just use `$y = \sin(t)$` or `$$y = \sin(t)$$` in a new line. Tables, in-page links, text formatting, heck even code! Everything can be written in markdown. Let me let you in on a secret! This very page you are reading is in Markdown.

Why not Latex directly? Because it is 202x! No one should be writing stuff directly in LaTeX. Fancy Machine Learning or Artificial Intelligence or whatever should convert it exactly the way I want it. We aren't there yet, but this is one step better. This lets you focus on the content, and the Pandoc and the template takes care of making it seem like you know a lot to your professors.

## Installation

Install pandoc, miktex(or equivalent), Python 3.7+. Linux users may use the `install.sh` script to install all dependencies. Make sure you can access all of them from anywhere.

Download and extract this repository to any location of your choice.

Add the directory to your path, so that typing builder.py should run it, albeit with errors.

## How to use

### New project

Run `builder.py new new_project_name`

This creates 2 files, `new_project_name.md` and `new_project_name.bib`.

`new_project_name.md` is where you put your content. Markdown syntax is already available in the file. Once you have read it, clear it and put your content. Add the metadata.

`new_project_name.bib` is where all your references go in bibtex format. Almost all websites allow you to download citations in bibtex. Cite as [@citationname]. For example, [@einstein] will cite the bibtex entry with name `einstein`

### Build paper

This is where the magic happens.

Run `builder.py pdf new_project_name.md`

And voila, if you've done everything correctly, you should have `new_project_name.pdf` in your directory!

Incase you are unable to install miktex, you can also use `builder.py latex new_project_name.md` which creates a latex file `new_project_name.tex` which you can compile online using Overleaf.

## Can't I simply run a setup.exe to install

While I would love to do that, right now this project is still in it's nascent stage. I want to package everything in a single installable, and write the core in some compilable language like C++ or something. I'll eventually do it, but until then ¯\\\_(ツ)\_/¯. If someone has any ideas on how to package, reach out in the Issues tab!

## I have a MUCH better template

We'd LOVE to add more templates. Make a template according to pandoc's rules, and send in a PR. Don't know what any of this is? That's ok, share an Overleaf or some such template which we'll try to add if we like it and have time!

## I love this!

Why thanks! Drop in a thanks to Dhruva @ ms18163 or Mayukh @ ms18046
