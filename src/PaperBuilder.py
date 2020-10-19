import argparse
from shutil import copyfile
import os.path

rootpath = os.path.dirname(os.path.abspath(__file__))


class UnknownTypeException(Exception):
    pass


def debug(msg):
    if args.debug:
        print(msg)


def new_project(name):
    """
    Create a new Project with name
    """
    newfile = name
    if args.noop:
        return
    copyfile(rootpath + "/template.md", newfile + ".md")
    copyfile(rootpath + "/bibliography.bib", "bibliography.bib")


def build(name, build_type):
    """Build file with type

    Args:
        names (str): The name of the file
        type (str): Either pdf or latex
    """
    call_template = "pandoc --variable rootpath=\"{rootpath}\" --citeproc --csl \"{rootpath}/default/ieee.csl\" --template \"{rootpath}/default/default.tex\""
    if build_type == "pdf":
        call_template += " -i \"{filename}{ext}\" -o \"{filename}.pdf\""
    elif build_type == "latex":
        call_template += " -s -i \"{filename}{ext}\" -o \"{filename}.tex\""
    else:
        raise UnknownTypeException()
    if args.noop:
        return
    os.system(call_template.format(
        rootpath=rootpath, filename=name, ext=build_type
    ))


parser = argparse.ArgumentParser(description='Build IISER-M PDF Templates')
parser.add_argument('action', type=str,
                    help='Action to be taken', choices=['new', 'pdf', 'latex'])
parser.add_argument('name', type=str, help="Name to create/build")
parser.add_argument('-noop', action='store_true', help="No operation mode")
parser.add_argument('-debug', action='store_true', help="Debug mode")

args = parser.parse_args()

if args.action == "new":
    debug("Create a new project with name "+args.name)
    new_project(args.name)
else:
    debug("Build "+args.name+" as "+args.action)
    build(args.name, args.action)
