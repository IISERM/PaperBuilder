#! /usr/bin/env python3

import argparse
from shutil import copyfile
import os.path
from os.path import dirname as parent
from subprocess import run
from sys import argv, exit


def resolve_root(filepath):
    rootpath = parent(filepath)
    while not os.path.isdir(rootpath + "/default"):
        rootpath = parent(rootpath)
    return rootpath.replace("\\", "/")


rootpath = resolve_root(os.path.abspath(argv[0]))
TYPE_TEMPLATE = {"pdf": "report.tex", "ltx": "report.tex",
                 "report": "report.tex", "ltxreport": "report.tex",
                 "assign": "assign.tex", "ltxassign": "assign.tex",
                 "slides": "slides.html"}
DEBUG = False
NOOP = False


class UnknownTypeException(Exception):
    pass


class ArgumentParserError(Exception):
    pass


class ThrowingArgumentParser(argparse.ArgumentParser):
    def error(self, message):
        raise ArgumentParserError(message)


def debug(msg):
    if DEBUG:
        print(msg)


def new_project(path):
    """
    Create a new Project with name
    """
    if NOOP:
        return
    os.mkdir(path)
    copyfile(rootpath + "/template.md", path + "/content.md")
    copyfile(rootpath + "/bibliography.bib", path + "/bibliography.bib")
    return path


def build(path, build_type, otherargs):
    """Build file with type

    Args:
        names (str): The name of the file
        type (str): One of build types
        otherargs (str): Other Arguments passed to pandoc
    """
    if os.path.isfile(path):
        dir = os.path.dirname(path)
        fn, ext = os.path.splitext(os.path.basename(path))
    else:
        dir = path
        fn, ext = "content", ".md"
    debug("dir = " + dir)
    debug("fn = " + fn)
    debug("ext = " + ext)
    call_template = "pandoc --variable rootpath=\"{rootpath}\" --citeproc --csl \"{rootpath}/default/ieee.csl\" --template \"{rootpath}/default/{template}\""
    call_template += " "+otherargs+" "
    
    if build_type in ["pdf", "report", "assign"]:
        outext = "pdf"
        call_template += "-H \"{rootpath}/default/remove_float.tex\""
    elif build_type in ["ltx", "ltxreport", "ltxassign"]:
        outext = "tex"
        call_template += " -s"
    elif build_type in ["slides"]:
        outext = "html"
        call_template += "--mathjax --slide-level 2 -s -t revealjs"
    else:
        raise UnknownTypeException()
    
    call_template += " -i \"{filename}{ext}\" -o \"{filename}.{outext}\""
    
    if NOOP:
        return

    command = call_template.format(
        rootpath=rootpath, projectpath=dir,
        filename=fn, ext=ext, outext=outext,
        template=TYPE_TEMPLATE[build_type]
    )

    debug("Running " + command + " at " + dir)
    run(command, cwd=dir, shell=True)
    return os.path.join(dir, fn+"."+outext)


def interactive():
    while True:
        print("Enter help for info")
        print("Or exit")
        e = input("Enter command: ")
        if e == "exit":
            exit()
        try:
            args = parser.parse_args(e.split())
            main(args)
        except Exception as e:
            print(e)
        print("=====\n")


parser = ThrowingArgumentParser(
    description='Build IISER-M PDF Templates')
parser.add_argument('action', nargs=1,
                    help='Action to be taken', choices=['new', 'pdf', 'ltx', 'report', 'assign', 'ltxreport', 'ltxassign', 'slides'])
parser.add_argument('path', nargs=1, type=str, help="Path to create/build")
parser.add_argument('--noop', action='store_true', help="No operation mode")
parser.add_argument('--debug', action='store_true', help="Debug mode")
parser.add_argument('--extra', nargs="?",
                    type=str, help="Extra args to pandoc",
                    const=["--highlight-style=breezedark --pdf-engine=xelatex -V mainfont=\"TeX Gyre Pagella\" -V monofont=JuliaMono"],
                    default=[""])
args = None
try:
    args = parser.parse_args()
    args.action = args.action[-1]
    args.path = args.path[-1]
except:
    parser.parse_args(['-h'])

DEBUG, NOOP = args.debug, args.noop


def main(args):
    debug(args.action)
    if args.action == "new":
        debug("Create a new project at "+args.path)
        return new_project(args.path)
    else:
        debug("Build "+args.path+" as "+args.action)
        return build(
            args.path, args.action,
            " ".join(args.extra) if args.extra else ""
        )


if args.debug:
    print("===DEBUG MODE===")

if args.action == None:
    #interactive()
    pass
else:
    print(main(args))
