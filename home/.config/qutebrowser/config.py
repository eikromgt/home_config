import os

config.load_autoconfig(False)

config.source("base16-gruvbox-dark-hard.config.py")

config.bind("d", "scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down")
config.bind("u", "scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up")
config.bind("D", "tab-close")
config.bind("U", "undo")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")

c.auto_save.session = True

c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"

c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.pinned.odd.bg = c.colors.tabs.pinned.even.bg
c.colors.tabs.pinned.odd.fg = c.colors.tabs.pinned.even.fg
c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.pinned.selected.even.bg
c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.pinned.selected.even.fg
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg
c.colors.completion.odd.bg = c.colors.completion.even.bg

c.content.javascript.clipboard = "access"

c.zoom.default = "150%"

c.downloads.location.directory = "~/dl"

c.editor.command = ["kitty", "helix", "{file}"]

c.fileselect.handler = "external"
c.fileselect.single_file.command = ["kitty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.multiple_files.command = ["kitty", "-e", "yazi", "--chooser-file={}"]
c.fileselect.folder.command = ["kitty", "-e", "yazi", "--chooser-file={}"]
