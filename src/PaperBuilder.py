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
    os.mkdir(path)
    if NOOP:
        return
    copyfile(rootpath + "/template.md", path + "/content.md")
    copyfile(rootpath + "/bibliography.bib", path + "/bibliography.bib")


def build(path, build_type):
    """Build file with type

    Args:
        names (str): The name of the file
        type (str): Either pdf or latex
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
    call_template = "pandoc --variable rootpath=\"{rootpath}\" --citeproc --csl \"{rootpath}/default/ieee.csl\" --template \"{rootpath}/default/default.tex\""
    if build_type == "pdf":
        call_template += " -i \"{filename}{ext}\" -o \"{filename}.pdf\""
    elif build_type == "latex":
        call_template += " -s -i \"{filename}{ext}\" -o \"{filename}.tex\""
    else:
        raise UnknownTypeException()
    if NOOP:
        return
    command = call_template.format(
        rootpath=rootpath, projectpath=dir, filename=fn, ext=ext
    )
    debug("Running " + call_template + " at " + dir)
    run(command, cwd=dir, shell=True)


def interactive():
    while True:
        print("Example: new new/project/path")
        print("Example: pdf path/to/project")
        print("Example: latex path/to/project")
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
parser.add_argument('action', nargs="?",
                    help='Action to be taken', choices=[None, 'new', 'pdf', 'latex'])
parser.add_argument('path', nargs="?", type=str, help="Path to create/build")
parser.add_argument('--noop', action='store_true', help="No operation mode")
parser.add_argument('--debug', action='store_true', help="Debug mode")

args = parser.parse_args()
DEBUG, NOOP = args.debug, args.noop


def main(args):
    if args.action == "new":
        debug("Create a new project at "+args.path)
        new_project(args.path)
    elif args.action in ["pdf", "latex"]:
        debug("Build "+args.path+" as "+args.action)
        build(args.path, args.action)
    else:
        raise UnknownTypeException()


if args.debug:
    print("===DEBUG MODE===")

if args.action == None:
    interactive()
else:
    main(args)
