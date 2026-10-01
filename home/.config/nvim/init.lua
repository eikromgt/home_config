--==============================================================================
-- Basic Settings
--==============================================================================
vim.opt.encoding        = "utf-8"
vim.opt.fileencoding    = "utf-8"

vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.expandtab       = true
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4

vim.opt.background      = "dark"
vim.opt.termguicolors   = true
vim.opt.signcolumn      = "yes:1"
vim.opt.wrap            = false
vim.opt.cmdheight       = 0
vim.opt.showmode        = false
vim.opt.splitright      = true
vim.opt.splitkeep       = "screen"

vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.display         = "uhex"

vim.opt.clipboard:append("unnamedplus")
vim.opt.fillchars:append({ eob = " ", diff = " " })
vim.opt.matchpairs:append("<:>")
vim.api.nvim_create_autocmd("BufEnter",  { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.lsp.log.set_level("off")

--==============================================================================
-- Global Variables
--==============================================================================
local leetcodeCppBeforeInjection = [[
#include <iostream>
#include <string>
#include <stdint.h>
#include <memory>
#include <cmath>
#include <random>
#include <vector>
#include <list>
#include <array>
#include <map>
#include <unordered_map>
#include <set>
#include <unordered_set>
#include <queue>
#include <stack>
#include <bitset>
#include <limits>
#include <utility>
#include <algorithm>
#include <functional>
#include <mutex>
#include <ranges>
#include <print>
using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode() : val(0), next(nullptr) {}
    ListNode(int x) : val(x), next(nullptr) {}
    ListNode(int x, ListNode *next) : val(x), next(next) {}
};

struct TreeNode {
 int val;
 TreeNode *left;
 TreeNode *right;
 TreeNode() : val(0), left(nullptr), right(nullptr) {}
 TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
 TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};
]]

local leetcodePythonBeforeInjection = [[
from typing import Optional
from typing import List
import collections
import itertools
import math
import heapq
import bisect
import copy
import numpy
import random
]]

local leetcodeGoBeforeInjection = [[
package main

import (
    "fmt"
    "strings"
    "math"
    "math/bits"
)

type TreeNode struct {
  Val int
  Left *TreeNode
  Right *TreeNode
}
]]

--==============================================================================
-- Keyboard Shortcuts and Mappings
--==============================================================================
vim.keymap.set("n", "<Space>", "<Nop>",  { noremap = true })
vim.g.mapleader         = " "

vim.keymap.set("x", "p",       "\"_dP")

vim.keymap.set("n", "<A-v>",   "<C-v>",  { noremap = true })
vim.keymap.set("i", "<C-BS>",  "<C-w>",  { noremap = true })

vim.keymap.set("n", "<A-W>",   "<C-w>c", { noremap = true })
vim.keymap.set("n", "<A-S>",   "<C-w>v", { noremap = true })
vim.keymap.set("n", "<A-w>",   "<C-w>", { noremap = true })
vim.keymap.set("n", "<A-l>",   "<C-w>l", { noremap = true })
vim.keymap.set("n", "<A-h>",   "<C-w>h", { noremap = true })
vim.keymap.set("n", "<A-k>",   "<C-w>k", { noremap = true })
vim.keymap.set("n", "<A-j>",   "<C-w>j", { noremap = true })
vim.keymap.set("n", "<A-L>",   "<C-w>L", { noremap = true })
vim.keymap.set("n", "<A-L>",   "<C-w>L", { noremap = true })
vim.keymap.set("n", "<A-H>",   "<C-w>H", { noremap = true })
vim.keymap.set("n", "<A-K>",   "<C-w>K", { noremap = true })
vim.keymap.set("n", "<A-J>",   "<C-w>J", { noremap = true })

vim.keymap.set("n", "<Leader>{", "\"oddO{<CR>}<Esc>\"oP=i{",  { noremap = true })
vim.keymap.set("v", "<Leader>{", "\"odO{<CR>}<Esc>\"oP=i{",   { noremap = true })

vim.keymap.set("n", "<A-a>",   "<Cmd>%!xxd<CR>",        { noremap = true })
vim.keymap.set("n", "<A-S-a>",   "<Cmd>%!xxd -r<CR>",   { noremap = true })

vim.keymap.set("n", "<A-p>",   ":e ",                   { noremap = true })
vim.keymap.set("n", "<A-S-p>", ":",                     { noremap = true })
vim.keymap.set("n", "<A-z>",   ":vertical help ",       { noremap = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(_)
        vim.keymap.set("n",          "<Leader>q", vim.diagnostic.open_float,  { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<Leader>[", vim.diagnostic.goto_prev,   { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<Leader>]", vim.diagnostic.goto_next,   { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<Leader>o", vim.diagnostic.setloclist,  { buffer = bufnr, noremap = true })

        vim.keymap.set("n",          "<A-u>",     vim.lsp.buf.declaration,    { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<A-y>",     vim.lsp.buf.definition,     { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<A-;>",     vim.lsp.buf.implementation, { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<A-q>",     vim.lsp.buf.hover,          { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<Leader>y", vim.lsp.buf.references,     { buffer = bufnr, noremap = true })
        vim.keymap.set("n",          "<A-S-r>",   vim.lsp.buf.rename,         { buffer = bufnr, noremap = true })
        vim.keymap.set({ "n", "v" }, "<Leader>v", vim.lsp.buf.code_action,    { buffer = bufnr, noremap = true })
    end,
})

-- copy current filepath to system clipboard
vim.keymap.set("n", "<Leader>tf", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        vim.fn.setreg("+", filepath)
        vim.notify("filepath copied: " .. filepath, "info")
    end, { noremap = true, silent = true })

-- copy current line git commit hash to system clipboard
vim.keymap.set("n", "<Leader>tc", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        local line = vim.api.nvim_win_get_cursor(0)[1]

        local sha = vim.fn.system("git blame -sp -L " .. line .. "," .. line .. " "..  filepath .. " | head -n1 | cut -d ' ' -f 1")
        vim.fn.setreg("+", sha)
        vim.notify(filepath .. ":" .. line .. " " .. sha, "info")
    end, { noremap = true, silent = true })

--==============================================================================
-- Auto Command
--==============================================================================
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  end
})

vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("wincmd =")
  end
})

--==============================================================================
-- Plugin Manager: built-in vim.pack
--==============================================================================
-- Install, update (:packupdate), and delete (:packdelete) plugins. Plugins live
-- in stdpath("data")/site/pack/core/opt/<name> and are all loaded at startup
-- (eagerly). Configuration is done by calling require(...).setup() below. Plugin
-- revisions are tracked in the pack lockfile at stdpath("data")/packlock.
vim.pack.add({
    -- Environment
    "https://github.com/NotAShelf/direnv.nvim",
    -- Editor
    "https://github.com/smoka7/hop.nvim",
    "https://github.com/windwp/nvim-autopairs",
    "https://github.com/okuuva/auto-save.nvim",
    "https://github.com/kylechui/nvim-surround",
    -- Decoration
    "https://github.com/ellisonleao/gruvbox.nvim",
    "https://github.com/RRethy/vim-illuminate",
    "https://github.com/nvimdev/hlsearch.nvim",
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    -- Window
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/nvim-tree/nvim-web-devicons",
    "https://github.com/nvim-lualine/lualine.nvim",
    "https://github.com/yavorski/lualine-macro-recording.nvim",
    -- Tool
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-pack/nvim-spectre",
    "https://github.com/akinsho/toggleterm.nvim",
    "https://github.com/stevearc/overseer.nvim",
    "https://github.com/jemag/telescope-diff.nvim",
    "https://github.com/rcarriga/nvim-notify",
    "https://github.com/echasnovski/mini.nvim",
    "https://forge.barrettruth.com/barrettruth/live-server.nvim",
    "https://github.com/kdheepak/lazygit.nvim",
    "https://github.com/mikesmithgh/kitty-scrollback.nvim",
    -- Git
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/lewis6991/gitsigns.nvim",
    -- Completion
    "https://github.com/L3MON4D3/LuaSnip",
    "https://github.com/github/copilot.vim",
    "https://github.com/nickjvandyke/opencode.nvim",
    "https://github.com/saghen/blink.lib",
    "https://github.com/saghen/blink.cmp",
    -- LSP
    "https://github.com/williamboman/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/williamboman/mason-lspconfig.nvim",
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/b0o/schemastore.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    -- DAP
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/igorlfs/nvim-dap-view",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    -- Application
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/kawre/leetcode.nvim",
}, { confirm = false })

vim.keymap.set({ "n" }, "<Leader>rx", function() vim.pack.update() end, { noremap = true, desc = "Update plugins" })

--==============================================================================
-- Environment
--==============================================================================
require("direnv").setup({
    autoload_direnv = true,
    statusline = {
        enabled = true,
        icon = "󱚟",
    },
    keybindings = {
        allow = "<Leader>da",
        deny = "<Leader>dc",
        reload = "<Leader>dr",
        edit = "<Leader>de",
    },
})

--==============================================================================
-- Editor
--==============================================================================
do
    local hop = require("hop")
    local directions = require("hop.hint").HintDirection
    hop.setup()

    vim.keymap.set({ "n", "v" }, "f", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true })                    end, { remap = true })
    vim.keymap.set({ "n", "v" }, "F", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })                    end, { remap = true })
    vim.keymap.set({ "n", "v" }, "t", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 })  end, { remap = true })
    vim.keymap.set({ "n", "v" }, "T", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })   end, { remap = true })
    vim.keymap.set({ "n", "v" }, "<Leader>w", "<Cmd>HopWord<CR>",  { noremap = true })
    vim.keymap.set({ "n", "v" }, "<Leader>c", "<Cmd>HopChar1<CR>", { noremap = true })
end

require("nvim-autopairs").setup({
    enable_bracket_in_quote = false,
})

require("auto-save").setup({
    immediate_save = { "QuitPre", "VimSuspend" },
    defer_save = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost", },
    debounce_delay = 300,
    condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if
            fn.getbufvar(buf, "&modifiable") == 1 and
            utils.not_in(fn.getbufvar(buf, "&filetype"), {"kitty-scrollback", "zsh"}) then
            return true
        end
        return false
    end,
})

require("nvim-surround").setup()

--==============================================================================
-- Decoration
--==============================================================================
require("gruvbox").setup({
    transparent_mode = true,
})
vim.cmd.colorscheme("gruvbox")

require("hlsearch").setup()

-- vim-illuminate auto-starts from its plugin/ file. It defines its highlight
-- groups with `:hi default`, so our links (set here) win regardless of order.
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

vim.api.nvim_create_autocmd({"WinEnter", "FocusGained"}, {
    callback = function()
        vim.wo.cursorline = true
        require("illuminate").resume_buf()
    end
})
vim.api.nvim_create_autocmd({"WinLeave", "FocusLost"}, {
    callback = function()
        vim.wo.cursorline = false
        require("illuminate").pause_buf()
    end
})

do
    local languages = { "cpp", "c", "python", "go", "cmake", "typst", "javascript", "html", "css", "json", "glsl", }
    require("nvim-treesitter").install(languages)
    vim.api.nvim_create_autocmd("FileType", {
        pattern = languages,
        callback = function()
            vim.treesitter.start()
        end,
    })
end

--==============================================================================
-- Window
--==============================================================================
require("nvim-tree").setup({
    view = {
        signcolumn = "auto",
        side       = "right"
    },
    renderer = {
        indent_width = 1
    },
    filters = {
        git_ignored = false,
        dotfiles = false
    },
})
vim.keymap.set({ "n" }, "<A-e>", "<Cmd>NvimTreeFindFileToggle<CR>", { noremap = true })

do
    local function direnv_status()
        return require("direnv").statusline()
    end
    local function relative_filepath()
        return vim.fn.expand("%:.")
    end
    require("lualine").setup({
        options = {
            globalstatus = true,
            section_separators = "",
            component_separators = "",
            disabled_filetypes = {
                winbar = {
                    "dap-view",
                    "dap-repl",
                    "dap-view-term",
                },
            },
        },
        sections = {
            lualine_a = { "branch", "diff", "lsp_status", require("opencode").statusline, direnv_status, "diagnostics" },
            lualine_b = { relative_filepath, "macro_recording" },
            lualine_c = { "windows" },
            lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
            lualine_z = { "selectioncount", "location", },
        }
    })
end

--==============================================================================
-- Tool
--==============================================================================
do
    local telescope = require("telescope.builtin")
    vim.keymap.set("n", "<leader>fp", telescope.find_files, { noremap = true })
    vim.keymap.set("n", "<leader>ff", telescope.live_grep, { noremap = true })
    vim.keymap.set("n", "<leader>fh", telescope.pickers, { noremap = true })
    vim.keymap.set("n", "<leader>fb", telescope.buffers, { noremap = true })
    vim.keymap.set("n", "<leader>fh", telescope.help_tags, { noremap = true })
    vim.keymap.set("n", "<Leader>fw", function() telescope.grep_string({search = vim.fn.expand("<cword>")}) end, { noremap = true })
    vim.keymap.set("n", "<A-p>", telescope.find_files, { noremap = true })
    vim.keymap.set("n", "<A-f>", telescope.live_grep, { noremap = true })
    vim.keymap.set("n", "<A-S-f>", function() telescope.grep_string({search = vim.fn.expand("<cword>")}) end, { noremap = true })
end

require("spectre").setup()
vim.keymap.set("n", "<Leader>tr", function() require("spectre").toggle() end, { desc = "Toggle Spectre" })

do
    vim.opt.hidden = true
    require("toggleterm").setup({
        open_mapping        = "<A-`>",
        autochdir           = true,
        direction           = "float",
    })
    vim.keymap.set({ "n", "t" }, "<A-S-`>", "<Cmd>TermSelect<CR>", { noremap = true })
end

require("overseer").setup({
    dap = false,
    task_list = {
        min_height = 12,
    }
})
vim.keymap.set({ "n" }, "<Leader>rt", "<Cmd>OverseerRun<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<Leader>tt", "<Cmd>OverseerToggle<CR>", { noremap = true })

require("telescope").load_extension("diff")
vim.keymap.set("n", "<Leader>fd", function() require("telescope").extensions.diff.diff_files({ hidden = true }) end, { desc = "Compare 2 files" })
vim.keymap.set("n", "<Leader>fc", function() require("telescope").extensions.diff.diff_current({ hidden = true }) end, { desc = "Compare file with current" })

vim.notify = require("notify")
vim.notify.setup({
    render = "compact",
    stages = "slide",
    background_colour = "#1d2021",
    top_down = false
})
require("telescope").load_extension("notify")
vim.keymap.set({ "n" }, "<Leader>f/", "<Cmd>Telescope notify<CR>", { noremap = true })

require("mini.align").setup()
require("mini.trailspace").setup()
require("mini.move").setup({
    mappings = {
        left = "<C-A-h>",
        right = "<C-A-l>",
        down = "<C-A-j>",
        up = "<C-A-k>",
        line_left = "<C-A-h>",
        line_right = "<C-A-l>",
        line_down = "<C-A-j>",
        line_up = "<C-A-k>",
    },
})

vim.keymap.set("n", "<Leader>tl", "<Cmd>LiveServerToggle<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>rg", "<Cmd>LazyGit<CR>", { noremap = true })

require("kitty-scrollback").setup()

--==============================================================================
-- Git
--==============================================================================
require("diffview").setup({
    enhanced_diff_hl = true,
    file_panel = {
        listing_style = "tree",
        tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
        },
        win_config = {
            position = "right",
            width = 35,
            win_opts = {},
        },
    },
})
vim.keymap.set("n", "<Leader>do", ":DiffviewOpen", { noremap = true })
vim.keymap.set("n", "<Leader>dd", "<Cmd>DiffviewOpen<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>dq", "<Cmd>DiffviewClose<CR>", { noremap = true })
vim.keymap.set("n", "<A-]>", "]c", { noremap = true })
vim.keymap.set("n", "<A-[>", "[c", { noremap = true })

-- gitsigns' plugin/ file calls setup() with no args, which never resets the
-- config, so we can configure it directly here.
local gitsigns = require("gitsigns")
gitsigns.setup {
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = true
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    preview_config = {
    },
}
vim.keymap.set("n", "<Leader>tg", gitsigns.toggle_current_line_blame, { noremap = true, silent = true })

--==============================================================================
-- Completion
--==============================================================================
-- Build LuaSnip's optional jsregexp engine if it is not already present.
do
    local luasnip_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/LuaSnip"
    if vim.uv.fs_stat(luasnip_dir) ~= nil and vim.uv.fs_stat(luasnip_dir .. "/lua/luasnip-jsregexp.lua") == nil then
        pcall(function()
            vim.system({ "make", "install_jsregexp" }, { cwd = luasnip_dir }):wait()
        end)
    end
end

require("luasnip.loaders.from_vscode").load_standalone({
    path = "~/.config/Code/User/snippets/common.code-snippets",
    lazy = true
})

vim.keymap.set("i", "<A-S-Tab>", "copilot#Accept('\\<CR>')", {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

vim.keymap.set({ "n", "x" }, "<Leader>aa", function() require("opencode").ask("@this: ") end, { desc = "Ask OpenCode…" })
vim.keymap.set({ "n", "x" }, "<Leader>as", function() require("opencode").select() end, { desc = "Select OpenCode…" })
vim.keymap.set({ "n", "x" }, "<Leader>ar", function() return require("opencode").operator("@this") end, { desc = "Send range to OpenCode", expr = true })
vim.keymap.set({ "n" }, "<Leader>al", function() return require("opencode").operator("@this") .. "_" end, { desc = "Send line to OpenCode", expr = true })

require("blink.cmp").build():pwait()
require("blink.cmp").setup({
    keymap = {
        preset      = "default",
        ["<A-Tab>"] = { "accept", "fallback" },
        ["<Tab>"]   = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
        menu = { auto_show_delay_ms = 300, draw = { treesitter = { "lsp" } } },
    },
    sources   = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            cmdline = {
                min_keyword_length = function(ctx)
                    if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
                        return 3
                    end
                    return 0
                end
            }
        }
    },
    snippets  = { preset = "luasnip" },
    signature = { enabled = true },
    cmdline   = {
        keymap     = { preset = "inherit" },
        completion = { menu = { auto_show = true } },
    },
})

--==============================================================================
-- LSP
--==============================================================================
require("mason").setup({
    ui = {
        icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗"
        }
    }
})
vim.keymap.set({ "n" }, "<Leader>rm", "<Cmd>Mason<CR>", { noremap = true })

require("mason-tool-installer").setup {
    run_on_start = false,
    ensure_installed = {
        "codelldb",
        "cortex-debug",
        "glsl_analyzer",
        "neocmakelsp",
        "systemd-lsp",
    }
}

require("mason-lspconfig").setup({
    handlers = {
        ["neocmake"] = function()
            vim.lsp.config.neocmake = {
                init_options = {
                    lint = {
                        enable = false,
                    }
                },
            }
        end,
        ["verible"] = function()
            vim.lsp.config.verible = {
                root_dir     = function() return vim.fn.getcwd() end,
                handlers     = {
                    ["textDocument/publishDiagnostics"] = nil
                }
            }
        end,
    }
})

vim.lsp.config('*', {
    capabilities = require("blink.cmp").get_lsp_capabilities(),
})

vim.lsp.config.lua_ls = {
    settings = {
        Lua = { diagnostics = { globals = { "vim" } } }
    }
}

vim.lsp.config.tinymist = {
    offset_encoding = "utf-8",
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
        semanticTokens = "disable"
    }
}

vim.lsp.config.djlsp = {
    filetypes = { "htmldjango" },
}

vim.lsp.config.jsonls = {
    settings = {
        json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
        },
    }
}

vim.lsp.enable({"clangd", "basedpyright", "ruff", "lua_ls", "gopls", "rust_analyzer", "ts_ls"})
vim.lsp.enable({"tinymist", "bashls"})
vim.lsp.enable({"html", "cssls", "yamlls", "dockerls", "jsonls"})
vim.lsp.enable({"neocmake", "glsl_analyzer", "systemd_lsp", "emmet_language_server", "djlsp"})

require("typst-preview").setup({
    open_cmd = "chromium --new-window %s",
    invert_colors = '{"rest": "always","image": "never"}',
    dependencies_bin = {
        ["tinymist"] = "tinymist",
        ["websocat"] = "websocat",
    },
})
vim.keymap.set("n", "<Leader>tp", "<Cmd>TypstPreviewToggle<CR>", { noremap = true })

--==============================================================================
-- DAP
--==============================================================================
do
    local dap = require("dap")
    require("overseer").enable_dap()

    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" }
        }
    }
    dap.adapters.cortex_debug = {
        type = "server",
        port = "${port}",
        executable = {
            command = "codelldb",
            args = { "--port", "${port}" }
        }
    }
    dap.adapters.arm_none_eabi_gdb = {
        type = "server",
        port = "${port}",
        executable = {
            command = "arm-none-eabi-gdb",
            args = { "--port", "${port}" }
        }
    }

    vim.keymap.set("n", "<A-d>", function() require("dap").continue() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<A-n>", function() dap.step_over() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<A-i>", function() dap.step_into() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<A-o>", function() dap.step_out() end, { noremap = true, silent = true })
    vim.keymap.set("n", "<Leader>tb", function() dap.toggle_breakpoint() end, { noremap = true, silent = true })
end

do
    local dap = require("dap")
    local dap_view = require("dap-view")
    dap_view.setup({
        winbar = {
            show = true,
            sections = { "console", "watches", "exceptions", "breakpoints", "threads", "repl" },
            default_section = "console",
        },
    })
    dap.listeners.before.attach["dap-view-config"]           = function() dap_view.open() end
    dap.listeners.before.launch["dap-view-config"]           = function() dap_view.open() end
    dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end
    dap.listeners.before.event_exited["dap-view-config"]     = function() dap_view.close() end
    vim.keymap.set("n", "<Leader>td", function() dap_view.toggle() end, { noremap = true, silent = true })
end

require("nvim-dap-virtual-text").setup({
    virt_text_pos = "eol"
})

--==============================================================================
-- Application
--==============================================================================
vim.api.nvim_create_autocmd("FileType", {
    pattern = "leetcode.nvim",
    callback = function()
        vim.cmd("Copilot disable")
    end,
})

require("leetcode").setup({
    arg = "leetcode",
    lang = "golang",
    cn = {
        enabled = true,
        translator = false,
        translate_problems = false,
    },
    injector = {
        ["cpp"] = { before =  { leetcodeCppBeforeInjection }},
        ["python3"] = { before =  { leetcodePythonBeforeInjection }},
        ["golang"] = { before =  { leetcodeGoBeforeInjection }},
    }
})

vim.keymap.set("n", "<Leader>ll", "<Cmd>Leet list<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>li", "<Cmd>Leet inject<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lr", "<Cmd>Leet reset<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lt", "<Cmd>Leet test<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ls", "<Cmd>Leet submit<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lc", "<Cmd>Leet console<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lh", "<Cmd>Leet hints<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lm", "<Cmd>Leet menu<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lp", "<Cmd>Leet lang<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>ld", "<Cmd>Leet daily<CR>", { noremap = true })
vim.keymap.set("n", "<Leader>lq", "<Cmd>Leet exit<CR>", { noremap = true })
