config.load_autoconfig(False)

config.source("base16-gruvbox-dark-hard.config.py")

config.bind("d", "scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down ;; scroll down")
config.bind("u", "scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up ;; scroll up")
config.bind("D", "tab-close")
config.bind("U", "undo")

c.auto_save.session = True

c.colors.webpage.darkmode.enabled = True

c.colors.tabs.odd.bg = c.colors.tabs.even.bg
c.colors.tabs.pinned.odd.bg = c.colors.tabs.pinned.even.bg
c.colors.tabs.pinned.odd.fg = c.colors.tabs.pinned.even.fg
c.colors.tabs.pinned.selected.odd.bg = c.colors.tabs.pinned.selected.even.bg
c.colors.tabs.pinned.selected.odd.fg = c.colors.tabs.pinned.selected.even.fg
c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.bg
c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.fg
c.colors.completion.odd.bg = c.colors.completion.even.bg

c.zoom.default = "150%"


