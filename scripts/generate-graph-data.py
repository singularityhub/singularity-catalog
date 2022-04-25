#!/usr/bin/env python3

# **IMportant!** This is a development script to quickly get lists and then
# a matrix of packages. It is far from perfect, and I suspect buggy because
# the spack.yaml files come in so many different flavors. If you have an idea
# for how to clean this up, please submit a PR! It will be greatly appreciated!

import logging
import fnmatch
import os
import re
import yaml
from operator import itemgetter

from jinja2 import Environment, FileSystemLoader, select_autoescape

logging.basicConfig(level=logging.INFO)

# We want the root
here = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

env = Environment(
    autoescape=select_autoescape(["html"]), loader=FileSystemLoader("templates")
)


def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content


def recursive_find(base, pattern="*"):
    """recursive find will yield python files in all directory levels
    below a base path.

    Arguments:
      - base (str) : the base directory to search
      - pattern: a pattern to match, defaults to *.py
    """
    for root, _, filenames in os.walk(base):
        for filename in fnmatch.filter(filenames, pattern):
            yield os.path.join(root, filename)


def main():
    """
    Entrypoint to generation of graph data, container base counts
    """
    recipe_dir = os.path.join(here, "_recipes")
    recipes = list(recursive_find(recipe_dir))

    # let's keep track of bootstrap types and bases
    bootstraps = {}
    bases = {}
    versions = {}

    # Derive counts of latest vs other from versions
    tags = {"latest": 0, "other": 0}

    # First get bases names, and bootstrap type
    for recipe in recipes:
        content = read_file(recipe)

        # Find the bootstrap type
        match = re.search("bootstrap?\w+[:](?P<boostrap>.*)\n", content, re.IGNORECASE)
        if match:
            # Get rid of comment
            bootstrap = match.groups("bootstrap")[0].replace(":", "").strip().lower()
            bootstrap = bootstrap.split("#")[0]
            if "ping" in bootstrap:
                import IPython

                IPython.embed()
            if bootstrap not in bootstraps:
                bootstraps[bootstrap] = 0
            bootstraps[bootstrap] += 1

        # Find the base name and version
        match = re.search("from?\w[:](?P<from>.*)\n", content, re.IGNORECASE)
        if match:

            base = match.groups("from")[0].strip().strip(":").strip()

            for uri in ["docker://", "shub://", "library://"]:
                if base.startswith(uri):
                    base = base.replace(uri, "")

            base = base.split("#")[0]

            # Do we have a version?
            if ":" in base:
                base, version = base.split(":", 1)
                if base not in versions:
                    versions[base] = {}
                if version not in versions[base]:
                    versions[base][version] = 0
                versions[base][version] += 1
                if version == "latest":
                    tags["latest"] += 1
                else:
                    tags["other"] += 1

            # If we have an image path
            if base.startswith("./") or base.startswith("../"):
                base = base.split("/", 1)[-1]
            if ":" in base:
                print(base)
                base, version = base.split(":")
            if base not in bases:
                bases[base] = 0
            bases[base] += 1

    # Finally, just count org names
    orgs = {}
    for name, count in bases.items():
        if "/" in name:

            # shub can be used for a docker bootstrap (rarely). We will
            # count this as an shub base image
            if name.startswith("shub://"):
                name = name.replace("shub://", "")
                bootstraps["shub"] += 1
                bootstraps["docker"] -= 1

            # Try to account for registries we know about
            if re.search("(quay.io|registry.gitlab.com|ghcr.io|nvcr.io)", name):
                org = "/".join(name.split("/")[0:2])
            else:
                org = name.split("/")[0]
            # Skip these
            if org in [".", "..", ""]:
                continue
            if org and org not in orgs:
                orgs[org] = 0
            orgs[org] += 1

    def gen(items):
        """
        We can't use a list or else yaml saving sorts by name
        """
        items = sorted(items.items(), key=itemgetter(1))
        items.reverse()
        result = []
        for item in items:
            result.append({"name": item[0], "count": item[1]})
        return result

    # Save to data file
    data = {
        "bases": gen(bases),
        "bootstraps": gen(bootstraps),
        "orgs": gen(orgs),
        "versions": versions,
        "tags": tags,
    }
    saveto = os.path.join(here, "_data", "containers.yaml")
    with open(saveto, "w") as out:
        yaml.dump(data, out)


if __name__ == "__main__":
    main()
