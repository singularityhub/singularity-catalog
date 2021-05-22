#!/usr/bin/env python3

import logging
import tempfile
import fnmatch
import os
import re
from pathlib import Path
import json
import calendar
import time
import shutil
import yaml

from github import Github
from github.GithubException import UnknownObjectException, RateLimitExceededException
import git
from jinja2 import Environment, FileSystemLoader, select_autoescape

logging.basicConfig(level=logging.INFO)

# We want the root
here = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))

env = Environment(
    autoescape=select_autoescape(["html"]), loader=FileSystemLoader("templates")
)

# do not clone LFS files
os.environ["GIT_LFS_SKIP_SMUDGE"] = "1"
g = Github(os.environ["GITHUB_TOKEN"])
repos = []

core_rate_limit = g.get_rate_limit().core


def read_yaml(filename):
    with open(filename, "r") as fd:
        content = yaml.load(fd, Loader=yaml.FullLoader)
    return content


def read_file(filename):
    with open(filename, "r") as fd:
        content = fd.read()
    return content

class Repo:
    data_format = 2

    def __init__(self, github_repo, readme, filenames):
        for attr in [
            "full_name",
            "description",
            "stargazers_count",
            "subscribers_count",
        ]:
            setattr(self, attr, getattr(github_repo, attr))

        self.topics = github_repo.get_topics()
        self.updated_at = github_repo.updated_at.timestamp()
        self.filenames = list(filenames)

        try:
            self.latest_release = github_repo.get_latest_release().tag_name
        except UnknownObjectException:
            # no release
            self.latest_release = None

        if readme is not None:
            self.readme = g.render_markdown(readme)
        self.data_format = Repo.data_format


def rate_limit_wait():
    curr_timestamp = calendar.timegm(time.gmtime())
    reset_timestamp = calendar.timegm(core_rate_limit.reset.timetuple())
    # add 5 seconds to be sure the rate limit has been reset
    sleep_time = max(0, reset_timestamp - curr_timestamp) + 5
    logging.warning(f"Rate limit exceeded, waiting {sleep_time} seconds")
    time.sleep(sleep_time)


def call_rate_limit_aware(func):
    while True:
        try:
            return func()
        except RateLimitExceededException:
            rate_limit_wait()


def call_rate_limit_aware_decorator(func):
    def inner(*args, **kwargs):
        while True:
            try:
                return func(*args, **kwargs)
            except RateLimitExceededException:
                rate_limit_wait()

    return inner


def store_data():
    repos.sort(key=lambda repo: repo["stargazers_count"])

    # Save the js data ready to go, and data for jekyll
    datapath = os.path.join(here, "assets", "js", "repos.js")
    with open(datapath, "w") as out:
        print(env.get_template("repos.js").render(data=repos), file=out)

    # Also save to yaml in data folder
    datapath = os.path.join(here, "_data", "repos.yml")
    results = {}
    for repo in repos:
        results[repo["full_name"]] = repo
    with open(datapath, "w") as out:
        yaml.dump(results, out)


@call_rate_limit_aware_decorator
def combine_results(code_search):
    """
    Given a code search result, organize by repos
    """
    byrepo = {}
    lookup = {}
    files = {}

    for i, filename in enumerate(code_search):
        repo = filename.repository
        if "Singularity" not in os.path.basename(filename.path):
            continue

        if repo.full_name not in byrepo:
            byrepo[repo.full_name] = set()
            lookup[repo.full_name] = repo
        byrepo[repo.full_name].add(filename.path)
    return byrepo, lookup


def validate_recipe(filename):
    """
    Ensure that a Singularity recipe has a bootstrap:
    """
    try:
        content = read_file(filename)
        if re.search("bootstrap[:]", content, re.IGNORECASE):
            return True
    except yaml.YAMLError as exc:
        return False
    return False


def recursive_find(base, pattern="Singularity*"):
    for root, _, filenames in os.walk(base):
        for filename in fnmatch.filter(filenames, pattern):
            yield os.path.join(root, filename)


def main():
    """
    Entrypoint to catalog generation
    """
    blacklist = set(l.strip() for l in open("blacklist.txt", "r"))

    # This search seems to return the best results! We search by indexed,
    # and it only returns top 10, and we can hope that over time we get closed
    # to the actual ~4k results (if we preserve older results).
    code_search = g.search_code('"Bootstrap" in:file filename:Singularity NOT language:java NOT language:shell NOT language:python NOT language:json NOT language:markdown NOT language:text NOT language:html NOT language:rst NOT language:smarty NOT language:yaml NOT language:roff NOT language:vim NOT extension:ipynb', sort="indexed")

    # Create a directory structure with Singularity recipes
    data_dir = os.path.join(here, "_recipes")

    # Consolidate filenames by repository
    byrepo, lookup = combine_results(code_search)

    # If we already have an existing file, load it.
    repos_file = os.path.join(here, "assets", "js", "repos.js")
    old_repos = []
    if os.path.exists(repos_file):
        content = read_file(repos_file)
        old_repos = json.loads("\n".join(content.split('\n')[1:]))

    for i, reponame in enumerate(byrepo):

        if i < 165:
            continue
        # List of files
        repo = lookup[reponame]
        if i % 10 == 0:
            logging.info(f"{i} of {len(byrepo)} repos done")

        repo_dir = os.path.join(data_dir, repo.full_name)

        logging.info(f"Processing {repo.full_name}.")
        if repo.full_name in blacklist:
            continue

        with tempfile.TemporaryDirectory() as tmp:
            tmp = Path(tmp)

            # Create the repo directory
            if not os.path.exists(repo_dir):
                os.makedirs(repo_dir)

            # clone main branch
            try:
                git.Repo.clone_from(repo.clone_url, str(tmp), depth=1)
            except git.GitCommandError:
                continue

            # Look for any Singularity file!
            files = []            
            for recipe in recursive_find(str(tmp)):
                filename = recipe.replace(str(tmp),'').strip('/')
                recipe_dir = os.path.dirname(recipe)
                savepath = os.path.join(repo_dir, filename)
                savedir = os.path.dirname(savepath)

                if not os.path.exists(recipe):
                    continue
                if not os.path.exists(savedir):
                    os.makedirs(savedir)

                # Required to have bootstrap:
                if not validate_recipe(recipe):
                    continue

                shutil.copyfile(str(recipe), savepath)
                files.append(filename)

            # Look for a readme in the folder, then root
            readme_path = tmp / "README.md"
            if readme_path.exists():
                with open(readme_path, "r") as f:
                    readme = f.read()

        # If no Singularity recipes, no go
        if not files:
            continue
   
        call_rate_limit_aware(
            lambda: repos.append(Repo(repo, readme, files).__dict__)
        )      

        if len(repos) % 20 == 0:
            logging.info("Storing intermediate results.")
            store_data()

    # one final save
    store_data()

if __name__ == "__main__":
    main()
