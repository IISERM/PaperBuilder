#! /bin/python3

import sys
import os.path
import os
import random
from shutil import copyfile

newext = sys.argv[1]
files = sys.argv[2:]

rootpath = os.path.dirname(os.path.abspath(__file__))

if newext == "new":
    try:
        newfile = sys.argv[2]
    except IndexError:
        newfile = "newproject_"+str(random.randint(100, 999))

    print("Creating a new project " + newfile)
    copyfile(rootpath + "/template.md", newfile + ".md")
    copyfile(rootpath + "/template.bib", newfile + ".bib")

else:
    call_template = "pandoc --variable rootpath=\"{rootpath}\" --filter=pandoc-citeproc --csl \"{rootpath}/default/ieee.csl\" --template \"{rootpath}/default/default.tex\""
    if newext == "pdf":
        call_template += " -i \"{filename}{ext}\" -o \"{filename}.pdf\""
    elif newext == "latex":
        call_template += " -s -i \"{filename}{ext}\" -o \"{filename}.tex\""
    else:
        print("Unknown format. Only pdf and latex supported")
        exit()

    input(
        "Converting {files} to {newext}.\nEnter to continue, Ctrl-C to exit.".format(
            files=files,
            newext=newext
        )
    )

    for file in files:
        filename, ext = os.path.splitext(file)
        print("Converting", filename, ext)
        os.system(call_template.format(
            rootpath=rootpath, filename=filename, ext=ext
        ))
