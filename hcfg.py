#!/usr/bin/python3

import os
import sys
import subprocess
import logging
import argparse
from collections import deque
import concurrent.futures as cf

HOME_REPO_DIR = "home"

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)

def RunCmd(cmd, cwd=None):
    logging.debug("Running: %s", " ".join(cmd))
    subprocess.run(cmd, cwd=cwd, check=True)


def GitClone(task):
    url = f"https://github.com/{task["name"]}.git"
    path = task["path"]

    if os.path.exists(path):
        RunCmd(["git", "pull"], cwd=path)
        logging.info("Update %s successed!", task["name"])
        return

    os.makedirs(os.path.dirname(path))
    RunCmd(["git", "clone", "--depth=1", url, path])
    logging.info("Install %s successed", task["name"])


tasks = [
    {
        "name": "wdomitrz/kitty-gruvbox-theme",
        "path": os.path.expanduser("~/.config/kitty/kitty-gruvbox-theme"),
        "func": GitClone,
    },
    {
        "name": "eastack/zathura-gruvbox",
        "path": os.path.expanduser("~/.config/zathura/zathura-gruvbox"),
        "func": GitClone,
    },
    {
        "name": "ohmyzsh/ohmyzsh",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh"),
        "func": GitClone,
    },
    {
        "name": "zsh-users/zsh-autosuggestions",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions"),
        "func": GitClone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "zsh-users/zsh-syntax-highlighting",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"),
        "func": GitClone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "l4u/zsh-output-highlighting",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-output-highlighting"),
        "func": GitClone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "bennyyip/gruvbox-dark",
        "path": os.path.expanduser("~/.config/yazi/flavors/gruvbox-dark.yazi"),
        "func": lambda task: RunCmd(["ya", "pkg", "add", "bennyyip/gruvbox-dark"])
    },
]

def RunInstallTasks(tasks):
    nThread = max(os.cpu_count() // 2, 2)
    taskDict = {task["name"]: task for task in tasks}
    graph = {task["name"]: {"out": task.get("depends", []), "in": []} for task in tasks}

    for name, node in graph.items():
        for dep in node["out"]:
            graph[dep]["in"].append(name)

    executor = cf.ThreadPoolExecutor(max_workers=nThread)

    futures = {}
    for name, node in graph.items():
        if not node["out"]:
            future = executor.submit(taskDict[name]["func"], taskDict[name])
            futures[future] = name

    while futures:
        finishedFutures, _ = cf.wait(futures.keys(), return_when=cf.FIRST_COMPLETED)

        for future in finishedFutures:
            name = futures.pop(future)
            for next in graph[name]["in"]:
                graph[next]["out"].remove(name)
                if graph[next]["out"]:
                    continue

                nextFuture = executor.submit(taskDict[next]["func"], taskDict[next])
                futures[nextFuture] = next

def InstallConfig():
    try:
        RunInstallTasks(tasks)
    except Exception as e:
        logging.error("Task failed: %s", e)
        sys.exit(1)

    try:
        RunCmd(["rsync", "-av", f"{HOME_REPO_DIR}/", os.path.expanduser("~/")])
    except Exception as e:
        logging.error("Task failed: %s", e)
        sys.exit(1)


def UpdateConfig():
    threads = max(os.cpu_count() // 2, 2)
    repoHome = os.path.abspath(HOME_REPO_DIR)
    userHome = os.path.expanduser("~")

    filelist = subprocess.run(
        ["fd", "-tf", "-H", "."],
        capture_output=True, text=True, check=True, cwd=repoHome
        ).stdout

    subprocess.run(
        ["rsync", "-av", "--existing", "--files-from=-", userHome + "/", repoHome + "/"],
        input=filelist, text=True, check=True)


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command")

    subparsers.add_parser("install", help="Install configs into home directory")
    subparsers.add_parser("update", help="Update repo with files from home directory")

    args = parser.parse_args()

    if args.command == "install":
        InstallConfig()
    elif args.command == "update":
        UpdateConfig()


if __name__ == "__main__":
    main()
