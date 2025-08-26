#!/usr/bin/python3

import os
import subprocess
import shutil
import logging
import argparse
from concurrent.futures import ThreadPoolExecutor

HOME_REPO_DIR = "home"  # your repo’s home folder

# Config repos
repoConfigs = [
    {
        "name": "wdomitrz/kitty-gruvbox-theme",
        "dest": os.path.expanduser("~/.config/kitty/kitty-gruvbox-theme"),
    },
    {
        "name": "eastack/zathura-gruvbox",
        "dest": os.path.expanduser("~/.config/zathura/zathura-gruvbox"),
    },
    {
        "name": "ohmyzsh/ohmyzsh",
        "dest": os.path.expanduser("~/.local/share/oh-my-zsh"),
    },
    {
        "name": "zsh-users/zsh-autosuggestions",
        "dest": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-autosuggestions"),
    },
    {
        "name": "zsh-users/zsh-syntax-highlighting",
        "dest": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-syntax-highlighting"),
    },
    {
        "name": "l4u/zsh-output-highlighting",
        "dest": os.path.expanduser("~/.local/share/oh-my-zsh/custom/plugins/zsh-output-highlighting"),
    },
    {
        "name": "bennyyip/gruvbox-dark",
        "cmd": ["ya", "pkg", "add", "bennyyip/gruvbox-dark"],
        "dest": os.path.expanduser("~/.config/yazi/flavors/gruvbox-dark.yazi"),
    },
]

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(message)s",
)


def RunCmd(cmd, cwd=None):
    logging.debug("Running: %s", " ".join(cmd))
    try:
        subprocess.run(cmd, cwd=cwd, check=True)
    except subprocess.CalledProcessError as e:
        logging.error("Command failed: %s", e)


def UpdateConfig():
    repoHome = os.path.abspath(HOME_REPO_DIR)
    userHome = os.path.expanduser("~")

    filelist = subprocess.run(
        ["fd", "-tf", "-H", "."],
        capture_output=True, text=True, check=True, cwd=repoHome
        ).stdout

    subprocess.run(
        ["rsync", "-av", "--existing", "--files-from=-", userHome + "/", repoHome + "/"],
        input=filelist, text=True, check=True)


def InstallRepo(repoConfig):
    path = repoConfig["dest"]
    if os.path.exists(path):
        logging.info("Already installed %s", repoConfig["name"])
        return

    if "cmd" in repoConfig:
        logging.info("Adding %s", repoConfig["name"])
        RunCmd(repoConfig["cmd"])
    else:
        logging.info("Cloning %s", repoConfig["name"])
        url = f"https://github.com/{repoConfig["name"]}.git"
        os.makedirs(os.path.dirname(path), exist_ok=True)
        RunCmd(["git", "clone", "--depth=1", url, path])


def InstallConfig():
    threads = max(os.cpu_count() // 2, 2)

    with ThreadPoolExecutor(max_workers=threads) as executor:
        executor.map(InstallRepo, repoConfigs)

    RunCmd(["rsync", "-av", f"{HOME_REPO_DIR}/", os.path.expanduser("~/")])


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
