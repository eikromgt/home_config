#!/usr/bin/python3

import os
import sys
import subprocess
import logging
import argparse
import concurrent.futures as cf

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)


def ensure_trailing_slash(path):
    if not path.endswith("/"):
        path += "/"
    return path


def run_cmd(cmd, **kwargs):
    defaults = {"check": True, "text": True}
    run_kwargs = {**defaults, **kwargs}

    logging.info("Running: %s", " ".join(cmd))
    try:
        return subprocess.run(cmd, **run_kwargs)
    except subprocess.CalledProcessError as e:
        logging.error("Command failed: %s", " ".join(cmd))
        if e.stdout:
            logging.error("stdout:\n%s", e.stdout)
        if e.stderr:
            logging.error("stderr:\n%s", e.stderr)
        raise


def git_clone(task):
    url = f"https://github.com/{task["name"]}.git"
    path = task["path"]

    if os.path.exists(path):
        run_cmd(["git", "pull"], cwd=path)
        logging.info("Update %s successed!", task["name"])
        return

    os.makedirs(os.path.dirname(path), exist_ok=True)
    run_cmd(["git", "clone", "--depth=1", url, path])
    logging.info("Install %s successed", task["name"])


def install_yazi_package(task):
    package = task["package"]

    result = run_cmd(["ya", "pkg", "list"], capture_output=True)
    if package in result.stdout:
        run_cmd(["ya", "pkg", "upgrade", package]),
    else:
        run_cmd(["ya", "pkg", "add", package]),


def install_config(task):
    dest_path = ensure_trailing_slash(task["dest_path"])
    src_path = ensure_trailing_slash(task["src_path"])

    cmd = ["rsync", "-av", src_path, dest_path]
    for exclude in task.get("excludes", []):
        cmd.extend(["--exclude", exclude])

    run_cmd(cmd)


def update_config(task):
    dest_path = ensure_trailing_slash(task["dest_path"])
    src_path = ensure_trailing_slash(task["src_path"])

    print(dest_path)

    cmd = ["fd", "-tf", "-H", "."]
    for exclude in task.get("excludes", []):
        cmd.extend(["--exclude", exclude])
    filelist = run_cmd(cmd, capture_output=True, cwd=dest_path).stdout

    cmd = ["rsync", "-av", "--existing", "--files-from=-", src_path, dest_path]
    for exclude in task.get("excludes", []):
        cmd.extend(["--exclude", exclude])
    print(cmd)
    run_cmd(cmd, input=filelist)


def install_arch(task):
    if os.geteuid() != 0:
        raise PermissionError(
            "install arch must be run as root (try: sudo ./hcfg.py install arch)"
        )

    mount_point = "/mnt"
    repo_path = os.path.dirname(os.path.abspath(__file__))
    repo_name = os.path.basename(repo_path)

    run_cmd(["pacstrap", "-K", mount_point, "--needed", "base", "linux", "linux-firmware",
             "amd-ucode", "intel-ucode", "python", "rsync"])

    fstab_path = os.path.join(mount_point, "etc/fstab")
    fstab = run_cmd(["genfstab", "-U", mount_point], capture_output=True).stdout

    with open(fstab_path, "w") as f:
        logging.info("Writing fstab to %s", fstab_path)
        f.write(fstab)

    run_cmd(["rsync", "-a", "--exclude=.git",
             ensure_trailing_slash(repo_path),
             os.path.join(mount_point, "opt", repo_name)])

    run_cmd(["arch-chroot", mount_point, os.path.join("/opt", repo_name, "install_arch.sh")])


home_install_tasks = [
    {
        "name": "install",
        "dest_path": os.path.expanduser("~"),
        "src_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "home"),
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
        "package": "bennyyip/gruvbox-dark",
        "func": install_yazi_package,
    },
]

home_update_tasks = [
    {
        "name": "update",
        "dest_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "home"),
        "src_path": os.path.expanduser("~"),
        "func": update_config,
    },
]

rootfs_install_tasks = [
    {
        "name": "install",
        "dest_path": "/",
        "excludes": ["/etc/sudoers.d"],
        "src_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "rootfs"),
        "func": install_config,
    },
    {
        "dest_path": "/",
        "src_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "rootfs"),
        "name": "install sudoers",
        "func": lambda task: run_cmd(["install", "-m", "440", "-o", "root", "-g", "root",
                                      os.path.join(task["src_path"], "etc/sudoers.d/10-wheel"),
                                      os.path.join(task["dest_path"], "etc/sudoers.d/10-wheel")]),
    },
]

rootfs_update_tasks = [
    {
        "name": "update",
        "dest_path": os.path.join(os.path.dirname(os.path.abspath(__file__)), "rootfs"),
        "src_path": "/",
        "excludes": ["/etc/sudoers.d"],
        "func": update_config,
    },
]

arch_tasks = [
    {
        "name": "install arch",
        "func": install_arch,
    }
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
            future.result()

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
    p = install_subparser.add_parser("arch", help="install arch linux system")
    p.set_defaults(func=handle_tasks, tasks=arch_tasks)

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
