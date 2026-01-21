#!/usr/bin/python3

import os
import sys
import subprocess
import logging
import argparse
from collections import deque
import concurrent.futures as cf


logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)


def run_cmd(cmd, cwd=None):
    logging.debug("Running: %s", " ".join(cmd))
    subprocess.run(cmd, cwd=cwd, check=True)


def git_clone(task):
    url = f"https://github.com/{task["name"]}.git"
    path = task["path"]

    if os.path.exists(path):
        run_cmd(["git", "pull"], cwd=path)
        logging.info("Update %s successed!", task["name"])
        return

    os.makedirs(os.path.dirname(path))
    run_cmd(["git", "clone", "--depth=1", url, path])
    logging.info("Install %s successed", task["name"])


def install_config(task):
    run_cmd(["rsync", "-av", task["src_path"] + "/", task["dest_path"] + "~/"])

def update_config(task):
    dest_path = task["dest_path"]
    src_path = task["src_path"]

    filelist = subprocess.run(
        ["fd", "-tf", "-H", "."],
        capture_output=True, text=True, check=True, cwd=dest_path
        ).stdout

    subprocess.run(
        ["rsync", "-av", "--existing", "--files-from=-", src_path + "/", dest_path + "/"],
        input=filelist, text=True, check=True)


home_install_tasks = [
    {
        "name": "install",
        "dest_path": os.path.expanduser("~"),
        "src_path": os.path.abspath("home"),
        "func": install_config,
    },
    {
        "name": "wdomitrz/kitty-gruvbox-theme",
        "path": os.path.expanduser("~/.config/kitty/kitty-gruvbox-theme"),
        "func": git_clone,
    },
    {
        "name": "eastack/zathura-gruvbox",
        "path": os.path.expanduser("~/.config/zathura/zathura-gruvbox"),
        "func": git_clone,
    },
    {
        "name": "ohmyzsh/ohmyzsh",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh"),
        "func": git_clone,
    },
    {
        "name": "zsh-users/zsh-autosuggestions",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions"),
        "func": git_clone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "zsh-users/zsh-syntax-highlighting",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"),
        "func": git_clone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "l4u/zsh-output-highlighting",
        "path": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-output-highlighting"),
        "func": git_clone,
        "depends": ["ohmyzsh/ohmyzsh"],
    },
    {
        "name": "bennyyip/gruvbox-dark",
        "path": os.path.expanduser("~/.config/yazi/flavors/gruvbox-dark.yazi"),
        "func": lambda task: run_cmd(["ya", "pkg", "add", "bennyyip/gruvbox-dark"]),
    },
]

home_update_tasks = [
    {
        "name": "update",
        "dest_path": os.path.abspath("home"),
        "src_path": os.path.expanduser("~"),
        "func": update_config,
    },
]

rootfs_install_tasks = [
    {
        "name": "install",
        "dest_path": "/",
        "src_path": os.path.abspath("rootfs"),
        "func": install_config,
    },
]

rootfs_update_tasks = [
    {
        "name": "update",
        "dest_path": os.path.abspath("rootfs"),
        "src_path": "/",
        "func": update_config,
    },
]

def run_tasks(tasks):
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


def handle_tasks(args):
    tasks = args.tasks
    try:
        run_tasks(tasks)
    except Exception as e:
        logging.error("Task failed: %s", e)
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser()
    subparsers = parser.add_subparsers(dest="command", required=True)

    install_parser = subparsers.add_parser("install", help="Install command")
    install_parser.set_defaults(func=handle_tasks, tasks=home_install_tasks)

    install_subparser = install_parser.add_subparsers()
    p = install_subparser.add_parser("home", help="Install home configurations")
    p.set_defaults(func=handle_tasks, tasks=home_install_tasks)
    p = install_subparser.add_parser("rootfs", help="Install system configurations")
    p.set_defaults(func=handle_tasks, tasks=rootfs_install_tasks)

    update_parser = subparsers.add_parser("update", help="Update command")
    update_parser.set_defaults(func=handle_tasks, tasks=home_update_tasks)

    update_subparser = update_parser.add_subparsers()
    p = update_subparser.add_parser("home", help="Update configurations from home directory")
    p.set_defaults(func=handle_tasks, tasks=home_update_tasks)
    p = update_subparser.add_parser("rootfs", help="Update configurations from rootfs")
    p.set_defaults(func=handle_tasks, tasks=rootfs_update_tasks)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
