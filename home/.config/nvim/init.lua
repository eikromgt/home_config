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

vim.opt.termguicolors   = true
vim.opt.cursorline      = true
vim.opt.signcolumn      = "no"
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

vim.lsp.set_log_level("off")

--==============================================================================
-- Global Variables
--==============================================================================
PluginPath      = vim.fn.stdpath("data") .. "/lazy"
CodePath        = "~/.config/Code"
CodeSnippets    = CodePath .. "/User/snippets/common.code-snippets"

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
using namespace std;
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

--==============================================================================
-- Keyboard Shortcuts and Mappings
--==============================================================================
vim.keymap.set("n", "<Space>", "<Nop>",  { noremap = true })
vim.g.mapleader         = " "

vim.keymap.set("n", "<A-v>",   "<C-v>",  { noremap = true })     vim.keymap.set("n", "<C-v>",  "<Nop>", { noremap = true })
vim.keymap.set("i", "<C-BS>",  "<C-w>",  { noremap = true })

vim.keymap.set("n", "<A-W>",   "<C-w>c", { noremap = true })     vim.keymap.set("n", "<C-w>c", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S>",   "<C-w>v", { noremap = true })     vim.keymap.set("n", "<C-w>v", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-l>",   "<C-w>l", { noremap = true })     vim.keymap.set("n", "<C-w>l", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-h>",   "<C-w>h", { noremap = true })     vim.keymap.set("n", "<C-w>h", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-k>",   "<C-w>k", { noremap = true })     vim.keymap.set("n", "<C-w>k", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-j>",   "<C-w>j", { noremap = true })     vim.keymap.set("n", "<C-w>j", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-L>",   "<C-w>L", { noremap = true })     vim.keymap.set("n", "<C-w>L", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-H>",   "<C-w>H", { noremap = true })     vim.keymap.set("n", "<C-w>H", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-K>",   "<C-w>K", { noremap = true })     vim.keymap.set("n", "<C-w>K", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-J>",   "<C-w>J", { noremap = true })     vim.keymap.set("n", "<C-w>J", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-.>", "<C-w>>", { noremap = true })     vim.keymap.set("n", "<C-w>>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-,>", "<C-w><", { noremap = true })     vim.keymap.set("n", "<C-w><", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-=>", "<C-w>+", { noremap = true })     vim.keymap.set("n", "<C-w>+", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-->", "<C-w>-", { noremap = true })     vim.keymap.set("n", "<C-w>-", "<Nop>", { noremap = true })

vim.keymap.set("n", "<Leader>{", "\"oddO{<CR>}<Esc>\"oP=i{",  { noremap = true })
vim.keymap.set("v", "<Leader>{", "\"odO{<CR>}<Esc>\"oP=i{",   { noremap = true })

vim.keymap.set("n", "<A-a>",   "<Cmd>%!xxd<CR>",        { noremap = true })
vim.keymap.set("n", "<A-S-a>",   "<Cmd>%!xxd -r<CR>",   { noremap = true })

vim.keymap.set("n", "<A-p>",   ":e ",                   { noremap = true })
vim.keymap.set("n", "<A-S-p>", ":",                     { noremap = true })
vim.keymap.set("n", "<A-z>",   ":vertical help ",       { noremap = true })

vim.keymap.del("n", "gri",     {})
vim.keymap.del("n", "gra",     {})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(_)
        vim.keymap.set("n",          "<Leader>q", vim.diagnostic.open_float, { noremap = true })
        vim.keymap.set("n",          "<Leader>[", vim.diagnostic.goto_prev,  { noremap = true })
        vim.keymap.set("n",          "<Leader>]", vim.diagnostic.goto_next,  { noremap = true })
        vim.keymap.set("n",          "<Leader>o", vim.diagnostic.setloclist, { noremap = true })

        vim.keymap.set("n",          "<A-u>",     vim.lsp.buf.declaration,   { noremap = true })
        vim.keymap.set("n",          "<A-y>",     vim.lsp.buf.definition,    { noremap = true })
        vim.keymap.set("n",          "<A-q>",     vim.lsp.buf.hover,         { noremap = true })
        vim.keymap.set("n",          "<Leader>y", vim.lsp.buf.references,    { noremap = true })
        vim.keymap.set("n",          "<Leader>r", vim.lsp.buf.rename,        { noremap = true })
        vim.keymap.set({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action,   { noremap = true })
    end,
})

-- copy current filepath to system clipboard
vim.keymap.set("n", "<Leader>tp", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        vim.fn.setreg("+", filepath)
        vim.notify("filepath copied: " .. filepath, "info")
    end, { noremap = true, silent = true })

-- copy current line git commit hash to system clipboard
vim.keymap.set("n", "<Leader>tb", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        local line = vim.api.nvim_win_get_cursor(0)[1]

        local sha = vim.fn.system("git blame -sp -L " .. line .. "," .. line .. " "..  filepath .. " | head -n1 | cut -d ' ' -f 1")
        vim.fn.setreg("+", sha)
        vim.notify(filepath .. ":" .. line .. " " .. sha, "info")
    end, { noremap = true, silent = true })

-- toggle signcolumn
vim.keymap.set("n", "<Leader>ts", function()
        local sc = vim.o.signcolumn
        if (sc == "no") then sc = "number" else sc = "no" end
        vim.notify("set signcolumn=" .. sc, "info")
        vim.opt.signcolumn = sc
    end,   { noremap = true })

--==============================================================================
-- Auto Command
--==============================================================================
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        vim.b.minitrailspace_disable = true;
    end
})

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })
  end
})

--==============================================================================
-- Plugin Manager: folke/lazy.nvim
--==============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.runtimepath:prepend(lazypath)
vim.keymap.set({ "n" }, "<Leader>x", "<Cmd>Lazy<CR>", { noremap = true })

require("lazy").setup({
    --==============================================================================
    -- Editor
    --==============================================================================
    { "vim-scripts/ReplaceWithRegister" },
    { "smoka7/hop.nvim", version  = "*",
        config = function()
            local hop = require("hop")
            local directions = require("hop.hint").HintDirection
            hop.setup();

            vim.keymap.set({ "n", "v" }, "f", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true })                    end, { remap = true })
            vim.keymap.set({ "n", "v" }, "F", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })                    end, { remap = true })
            vim.keymap.set({ "n", "v" }, "t", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 })  end, { remap = true })
            vim.keymap.set({ "n", "v" }, "T", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })   end, { remap = true })
            vim.keymap.set({ "n", "v" }, "<Leader>w", "<Cmd>HopWord<CR>",  { noremap = true })
            vim.keymap.set({ "n", "v" }, "<Leader>c", "<Cmd>HopChar1<CR>", { noremap = true })
        end
    },
    { "windwp/nvim-autopairs", event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup({
                enable_bracket_in_quote = false,
            })
        end
    },
    { "okuuva/auto-save.nvim",
        config = function()
            require("auto-save").setup({
                immediate_save = { "QuitPre", "VimSuspend" },
                defer_save = { "InsertLeave", "TextChanged", "BufLeave", "FocusLost", },
                debounce_delay = 1000,
            })
        end
    },
    { "kylechui/nvim-surround", version="*", event="VeryLazy",
        config = true
    },

    --==============================================================================
    -- Decoration
    --==============================================================================
    { "ellisonleao/gruvbox.nvim", priority=1000,
        config = function()
            require("gruvbox").setup({
                transparent_mode    = true,
            })
            vim.cmd.colorscheme("gruvbox")
        end
    },
    { "RRethy/vim-illuminate",
        config = function()
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
        end
    },
    { "nvimdev/hlsearch.nvim", event = "BufRead", config = true },
    { "HiPhish/rainbow-delimiters.nvim" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "python", "cmake", "glsl", "hjson", "typst", "verilog", "html" },
                additional_vim_regex_highlighting = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = function(_, buf)
                        local max_filesize = 5 * 1024 * 1024
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
            })
        end
    },

    --==============================================================================
    -- Window
    --==============================================================================
    { "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
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

            vim.keymap.set({ "n" }, "<A-e>",    "<Cmd>NvimTreeFindFileToggle<CR>",   { noremap = true })
        end
    },
    { "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", "yavorski/lualine-macro-recording.nvim"  },
        config = function()
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
                    lualine_a = {},
                    lualine_c = { "filename", "macro_recording", "%S" },
                    lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
                }
            })
        end
    },
    { "nvimdev/dashboard-nvim", event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons", "nvim-telescope/telescope.nvim" },
        config = true
    },

    --==============================================================================
    -- Tool
    --==============================================================================
    { "nvim-telescope/telescope.nvim", branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
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
    },
    { "gelguy/wilder.nvim", build = ":UpdateRemotePlugins",
        dependencies = { "roxma/nvim-yarp", "romgrk/fzy-lua-native" },
        config = function()
            local wilder = require("wilder")
            wilder.setup({
                modes       = { ":", "/", "?" },
            })

            wilder.set_option("pipeline", { wilder.branch(
                wilder.python_file_finder_pipeline({
                    file_command = { "fd", "-tf" },
                    dir_command  = { "fd", "-td" },
                    debounce     = 100
                }),
                wilder.substitute_pipeline({
                    pipeline    = wilder.python_search_pipeline({
                        skip_cmdtype_check  = 1,
                        pattern             = wilder.python_fuzzy_pattern(),
                    }),
                    debounce = 100
                }),
                wilder.cmdline_pipeline({
                    fuzzy        = 2,
                    fuzzy_filter = wilder.lua_fzy_filter(),
                    hide_in_substitute = true,
                    debounce     = 100
                }),
                wilder.python_search_pipeline({
                    pattern = wilder.python_fuzzy_pattern(),
                    debounce = 100
                })
            )})

            wilder.set_option("renderer", wilder.renderer_mux({
                [":"] = wilder.popupmenu_renderer({
                    highlighter     = { wilder.lua_fzy_highlighter() },
                    highlights      = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
                    left = {' ', wilder.popupmenu_devicons()},
                }),
                ["/"] = wilder.wildmenu_renderer({
                    highlighter = wilder.basic_highlighter(),
                    highlights  = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
                    left        = {" ", wilder.wildmenu_spinner(), " "},
                    right       = {" ", wilder.wildmenu_index()},
                }),
                ["?"] = wilder.wildmenu_renderer({
                    highlighter = wilder.basic_highlighter(),
                    highlights  = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
                    left        = {" ", wilder.wildmenu_spinner(), " "},
                    right       = {" ", wilder.wildmenu_index()},
                }),
            }))
        end

    },
    { "akinsho/toggleterm.nvim", version  = "*",
        config = function()
            vim.opt.hidden          = true
            require("toggleterm").setup({
                open_mapping        = "<A-`>",
                autochdir           = true,
            })

            vim.keymap.set({ "n", "t" }, "<A-S-`>", "<Cmd>TermSelect<CR>", { noremap = true })
        end
    },
    { "stevearc/overseer.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "akinsho/toggleterm.nvim" },
        config = function()
            require("overseer").setup({
                dap = false,
                task_list = {
                    min_height = 12,
                }
            })

            vim.keymap.set({ "n", "t" }, "<A-t>", "<Cmd>OverseerRun<CR>", { noremap = true })
            vim.keymap.set({ "n", "t" }, "<A-S-t>", "<Cmd>OverseerToggle<CR>", { noremap = true })
        end
    },
    { "jemag/telescope-diff.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("telescope").load_extension("diff")

            vim.keymap.set("n", "<Leader>fd", function() require("telescope").extensions.diff.diff_files({ hidden = true }) end,
            { desc = "Compare 2 files" })
            vim.keymap.set("n", "<Leader>fc",   function() require("telescope").extensions.diff.diff_current({ hidden = true }) end,
            { desc = "Compare file with current" })
        end
    },
    { "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            vim.notify.setup({
                render = "compact",
                stages = "slide",
                background_colour = "#1d2021",
                top_down = false
            })

            require("telescope").load_extension("notify")
            vim.keymap.set({ "n" }, "<Leader>f/", "<Cmd>Telescope notify<CR>", { noremap = true })
        end
    },
    { "echasnovski/mini.nvim", version = false,
        config = function()
            require("mini.align").setup()
            require("mini.trailspace").setup({

            });

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
        end
    },

    --==============================================================================
    -- Git
    --==============================================================================
    { "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
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

            vim.keymap.set("n", "<Leader>do",   ":DiffviewOpen",          { noremap = true })
            vim.keymap.set("n", "<Leader>dd",   "<Cmd>DiffviewOpen<CR>",  { noremap = true })
            vim.keymap.set("n", "<Leader>dq",   "<Cmd>DiffviewClose<CR>", { noremap = true })
            vim.keymap.set("n", "<A-]>", "]c",  { noremap = true })     vim.keymap.set("n", "]c", "<Nop>",  { noremap = true })
            vim.keymap.set("n", "<A-[>", "[c",  { noremap = true })     vim.keymap.set("n", "[c", "<Nop>",  { noremap = true })
        end
    },
    { "lewis6991/gitsigns.nvim",
        config = function()
            local gitsigns = require("gitsigns")

            gitsigns.setup {
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text_pos = "eol",
                    delay = 300,
                    ignore_whitespace = true
                },
                current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
                preview_config = {
                },
            }

            vim.keymap.set("n", "<Leader>b", gitsigns.toggle_current_line_blame,  { noremap = true, silent = true })
        end
    },

    --==============================================================================
    -- Completion
    --==============================================================================
    { "L3MON4D3/LuaSnip", version  = "2.*", build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").load_standalone({
                path = CodeSnippets,
                lazy = true
            })
        end
    },
    { "hrsh7th/cmp-nvim-lsp",
        config = function()
            require("cmp_nvim_lsp").default_capabilities().textDocument.completion.completionItem.snippetSupport = false
        end
    },
    { "hrsh7th/cmp-buffer"                                                  },
    { "hrsh7th/cmp-path"                                                    },
    { "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip"},
        config = function()
            local luasnip = require("luasnip")
            local cmp = require("cmp")
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources(
                {
                    { name = "nvim_lsp", entry_filter = function(entry, _) return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind() end },
                    { name = "luasnip" },
                    { name = "path" }
                }),
            })
        end
    },
    { "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" }           },
    { "b0o/schemastore.nvim"                                                },

    --==============================================================================
    -- LSP
    --==============================================================================
    { "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed   = "✓",
                        package_pending     = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            vim.keymap.set({ "n" }, "<Leader>m", "<Cmd>Mason<CR>", { noremap = true })
        end
    },
    { "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function()
            require('mason-tool-installer').setup {
                run_on_start = false,
                ensure_installed = {
                    "codelldb",
                    "cortex-debug",
                    "glsl_analyzer",
                    "neocmakelsp",
                    "tinymist"
                }
            }
        end
    },
    { "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "hrsh7th/cmp-nvim-lsp" },
        config = function()
            local cmp_nvim_lsp_cap = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup {
                            capabilities = cmp_nvim_lsp_cap
                        }
                    end,
                    ["neocmake"] = function()
                        require("lspconfig").neocmake.setup {
                            capabilities = cmp_nvim_lsp_cap,
                            init_options = {
                                lint = {
                                    enable = false,
                                }
                            },
                        }
                    end,
                    ["jsonls"] = function()
                        require("lspconfig").jsonls.setup {
                            capabilities = cmp_nvim_lsp_cap,
                            settings = {
                                json = {
                                    schemas = require("schemastore").json.schemas(),
                                    validate = { enable = true },
                                },
                            }
                        }
                    end,
                    ["tinymist"] = function()
                        require("lspconfig").tinymist.setup {
                            capabilities = cmp_nvim_lsp_cap,
                            offset_encoding = "utf-8",
                            settings     = {
                                formatterMode = "typstyle",
                                exportPdf = "never",
                                semanticTokens = "disable"
                            }
                        }
                    end,
                    ["verible"] = function()
                        require("lspconfig").verible.setup {
                            capabilities = cmp_nvim_lsp_cap,
                            root_dir     = function() return vim.fn.getcwd() end,
                            handlers     = {
                                ["textDocument/publishDiagnostics"] = nil
                            }
                        }
                    end,
                }
            })
        end
    },
    { "neovim/nvim-lspconfig",
        config = function()
            local cmp_nvim_lsp_cap = require("cmp_nvim_lsp").default_capabilities()

            require("lspconfig").clangd.setup {
                capabilities = cmp_nvim_lsp_cap,
                init_options = {
                    fallbackFlags = {"--std=c++23"}
                },
            }

            require("lspconfig").pylsp.setup {
                capabilities = cmp_nvim_lsp_cap,
                settings = { pylsp = {
                    plugins = {
                        pycodestyle = {
                            ignore = { "E501", "E306" }
                        }
                    }
                }},
            }

            require("lspconfig").lua_ls.setup {
                capabilities = cmp_nvim_lsp_cap,
                settings     = {
                    Lua = { diagnostics = { globals = { "vim" } } }
                }
            }

            require("lspconfig").bashls.setup {
                capabilities = cmp_nvim_lsp_cap,
            }
        end
    },
    { "lervag/vimtex",
        ft = "tex",
        init = function()
            vim.g.vimtex_mappings_prefix = "<Leader>e"
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_compiler_latexrun_engines = { _ = "xelatex", }
            vim.g.vimtex_compiler_latexmk_engines = { _ = "-xelatex", }
            vim.g.vimtex_quickfix_mode = 0

            -- auto sync pdf viewer position
            local vimtex_view_timer = nil
            local vimtex_view_debounce = 100
            local vimtex_view_last_line = -1
            vim.api.nvim_create_autocmd("CursorMoved", {
                pattern = "*.tex",
                callback = function()
                    local line = vim.fn.line(".")
                    if vimtex_view_timer or line == vimtex_view_last_line then
                        return
                    end
                    vimtex_view_last_line = line

                    vimtex_view_timer = vim.defer_fn(function()
                        vim.cmd("VimtexView")
                        vimtex_view_timer = nil
                    end, vimtex_view_debounce)
                end
            })
        end
    },
    { "chomosuke/typst-preview.nvim", ft = "typst", version = '1.*',
        config = function()
            require("typst-preview").setup({
                invert_colors = '{"rest": "auto","image": "never"}'
            })
        end
    },

    --==============================================================================
    -- DAP
    --==============================================================================
    { "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dap_vscode = require("dap.ext.vscode")

            require("overseer").patch_dap(true)

            dap_vscode.json_decode = require("overseer.json").decode

            if vim.fn.filereadable(".vscode/launch.json") then
                dap_vscode.load_launchjs(nil, { codelldb = { "c", "cpp", "glsl" }})
            end

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

            vim.keymap.set("n", "<A-d>", function()
                require("dap").continue()
            end,          { noremap = true, silent = true })
            vim.keymap.set("n", "<A-n>", function() dap.step_over() end,         { noremap = true, silent = true })
            vim.keymap.set("n", "<A-i>", function() dap.step_into() end,         { noremap = true, silent = true })
            vim.keymap.set("n", "<A-o>", function() dap.step_out() end,          { noremap = true, silent = true })
            vim.keymap.set("n", "<A-b>", function() dap.toggle_breakpoint() end, { noremap = true, silent = true })
        end
    },
    { "igorlfs/nvim-dap-view",
        dependencies = {"mfussenegger/nvim-dap" },
        config = function()
            local dap = require("dap")
            local dap_view = require("dap-view")

            dap_view.setup({
                winbar = {
                    show = true,
                    sections = { "console", "watches", "exceptions", "breakpoints", "threads", "repl" },
                    default_section = "threads",
                },
            })

            dap.listeners.before.attach["dap-view-config"]           = function() dap_view.open() end
            dap.listeners.before.launch["dap-view-config"]           = function() dap_view.open() end
            dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end
            dap.listeners.before.event_exited["dap-view-config"]     = function() dap_view.close() end

            vim.keymap.set("n", "<A-S-d>", function() dap_view.toggle() end, { noremap = true, silent = true })
        end
    },
    { "theHamsta/nvim-dap-virtual-text",
        dependencies = { "mfussenegger/nvim-dap",  "nvim-treesitter/nvim-treesitter", },
        config = function()
            require("nvim-dap-virtual-text").setup({
                virt_text_pos = "eol"
            })
        end
    },

    --==============================================================================
    -- Application
    --==============================================================================
    { "kawre/leetcode.nvim", lazy = vim.fn.argv()[1] ~= "leetcode",
        dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim", "nvim-treesitter/nvim-treesitter",
            "rcarriga/nvim-notify", "nvim-tree/nvim-web-devicons", },
        config = function()
            require("leetcode").setup({
                arg = "leetcode",
                cn = {
                    enabled = true,
                    translator = false,
                    translate_problems = false,
                },
                injector = {
                    ["cpp"] = { before =  { leetcodeCppBeforeInjection }},
                    ["python3"] = { before =  { leetcodePythonBeforeInjection }}
                }
            })

            vim.keymap.set("n", "<Leader>ll", "<Cmd>Leet list<CR>",     { noremap = true })
            vim.keymap.set("n", "<Leader>li", "<Cmd>Leet inject<CR>",   { noremap = true })
            vim.keymap.set("n", "<Leader>lr", "<Cmd>Leet reset<CR>",    { noremap = true })
            vim.keymap.set("n", "<Leader>lt", "<Cmd>Leet test<CR>",     { noremap = true })
            vim.keymap.set("n", "<Leader>ls", "<Cmd>Leet submit<CR>",   { noremap = true })
            vim.keymap.set("n", "<Leader>lc", "<Cmd>Leet console<CR>",  { noremap = true })
            vim.keymap.set("n", "<Leader>lh", "<Cmd>Leet hints<CR>",    { noremap = true })
            vim.keymap.set("n", "<Leader>lm", "<Cmd>Leet menu<CR>",     { noremap = true })
            vim.keymap.set("n", "<Leader>lp", "<Cmd>Leet lang<CR>",     { noremap = true })
            vim.keymap.set("n", "<Leader>ld", "<Cmd>Leet daily<CR>",     { noremap = true })
            vim.keymap.set("n", "<Leader>lq", "<Cmd>Leet exit<CR>",     { noremap = true })
        end
    },
},
{
  rocks = { enabled = false, hererocks = false },
})

