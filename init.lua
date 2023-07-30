--==============================================================================
-- Basic Settings
--==============================================================================
vim.opt.encoding        = "utf-8"

vim.opt.number          = true
vim.opt.relativenumber  = true
vim.opt.expandtab       = true
vim.opt.tabstop         = 4
vim.opt.shiftwidth      = 4

vim.opt.termguicolors   = true
vim.opt.cursorline      = true
vim.opt.signcolumn      = "number"
vim.opt.wrap            = false
vim.opt.cmdheight       = 0
vim.opt.showmode        = false
vim.opt.list            = true
vim.opt.listchars       = { nbsp = "␣", tab = "» ", trail = "•" }

vim.opt.clipboard:append("unnamedplus")
vim.api.nvim_create_autocmd("BufEnter",  { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

--==============================================================================
-- Keyboard Shortcuts and Mappings
--==============================================================================
vim.keymap.set("n", "<Space>", "<Nop>",  { noremap = true })
vim.g.mapleader         = " "

vim.keymap.set("n", "<A-v>",   "<C-v>",  { noremap = true })     vim.keymap.set("n", "<C-v>",  "<Nop>", { noremap = true })
vim.keymap.set("",  "<C-H>",   "<C-w>",  { noremap = true })

vim.keymap.set("n", "<A-W>",   "<C-w>c", { noremap = true })     vim.keymap.set("n", "<C-w>c", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-l>",   "<C-w>l", { noremap = true })     vim.keymap.set("n", "<C-w>l", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-h>",   "<C-w>h", { noremap = true })     vim.keymap.set("n", "<C-w>h", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-k>",   "<C-w>k", { noremap = true })     vim.keymap.set("n", "<C-w>k", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-j>",   "<C-w>j", { noremap = true })     vim.keymap.set("n", "<C-w>j", "<Nop>", { noremap = true })

vim.keymap.set("n", "<A-p>",   ":e ",             { noremap = true })
vim.keymap.set("n", "<A-z>",   ":vertical help ", { noremap = true })

--==============================================================================
-- Plugin Manager: folke/lazy.nvim
--==============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)
vim.keymap.set("n", "<A-x>", "<Cmd>Lazy<CR>", { noremap = true })

require("lazy").setup({
    { "nvim-tree/nvim-web-devicons",                                        },
    { "RRethy/vim-illuminate"                                               },
    { "ellisonleao/gruvbox.nvim",   priority = 1000                         },
    { "windwp/nvim-autopairs",      event    = "InsertEnter", opts = {}     },
    { "L3MON4D3/LuaSnip",           version      = "2.*"                    },
    { "vim-scripts/ReplaceWithRegister"                                     },
    { "Pocco81/auto-save.nvim"                                              },
    { "phaazon/hop.nvim",           branch   = "v2"                         },
    { "nvim-tree/nvim-tree.lua"                                             },
    { "nvim-lualine/lualine.nvim",                                          },
    { "nvim-lua/plenary.nvim"                                               },
    { "gaborvecsei/memento.nvim"                                            },
    { "roxma/nvim-yarp"                                                     },
    { "nixprime/cpsm",              cmd      = "UpdateRemotePlugins"        },
    { "romgrk/fzy-lua-native"                                               },
    { "sindrets/diffview.nvim"                                              },
    { "gelguy/wilder.nvim"                                                  },
    { "lewis6991/gitsigns.nvim"                                             },
    --{ "f-person/git-blame.nvim"                                             },
    { "romgrk/barbar.nvim"                                                  },
    { "akinsho/toggleterm.nvim",    version  = "*",           config = true },
    { "hrsh7th/cmp-nvim-lsp"                                                },
    { "hrsh7th/nvim-cmp"                                                    },
    { "williamboman/mason.nvim"                                             },
    { "williamboman/mason-lspconfig.nvim"                                   },
    { "neovim/nvim-lspconfig"                                               },
})

--==============================================================================
-- RRethy/vim-illuminate
--==============================================================================
require("illuminate").configure({
    providers = { "regex" }
})
vim.api.nvim_set_hl(0, "IlluminatedWordText",  { reverse = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead",  { reverse = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { reverse = true })

--==============================================================================
-- ellisonleao/gruvbox.nvim
--==============================================================================
vim.opt.background      = "dark"
require("gruvbox").setup({
    transparent_mode    = true,
    italic              = { strings = false }
})
vim.cmd("colorscheme gruvbox")

--==============================================================================
-- TODO: L3MON4D3/LuaSnip
--==============================================================================
local luasnip = require("luasnip")
--vim.keymap.set({"i"},       "<Tab>",   function() luasnip.expand() end, { noremap = false, silent = true })
--vim.keymap.set({"i", "s"},  "<Tab>",   function() luasnip.jump( 1) end, { noremap = false, silent = true })
--vim.keymap.set({"i", "s"},  "<S-Tab>", function() luasnip.jump(-1) end, { noremap = true,  silent = true })
--vim.keymap.set({"i", "s"},  "<A-c>",   function() if luasnip.choice_active() then luasnip.change_choice(1) end end, { noremap = true, silent = true })

--==============================================================================
-- Pocco81/auto-save.nvim
--==============================================================================
require("auto-save").setup({
    execution_message = { message = "" }
})

--==============================================================================
-- phaazon/hop.nvim
--==============================================================================
local hop = require('hop')
local directions = require('hop.hint').HintDirection
hop.setup()

vim.keymap.set({ "n", "v" }, "f", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true })                    end, { remap = true })
vim.keymap.set({ "n", "v" }, "F", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })                    end, { remap = true })
vim.keymap.set({ "n", "v" }, "t", function() hop.hint_char1({ direction = directions.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 })  end, { remap = true })
vim.keymap.set({ "n", "v" }, "T", function() hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })   end, { remap = true })
vim.keymap.set({ "n", "v" }, "<Leader>w", "<cmd>HopWord<cr>",  { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>c", "<cmd>HopChar1<cr>", { noremap = true })

--==============================================================================
-- nvim-tree/nvim-tree.lua
--==============================================================================
require("nvim-tree").setup()
vim.keymap.set("", "<A-e>",    "<cmd>NvimTreeToggle<cr>",   { noremap = true })

--==============================================================================
-- nvim-lualine/lualine.nvim
--==============================================================================
require("lualine").setup({
    options = {
        section_separators = "",
        component_separators = ""
    },
    sections = {
        lualine_a = {}
    }
})

--==============================================================================
-- fgaborvecsei/memento.nvim
--==============================================================================
vim.keymap.set("n", "<A-o>", "<Cmd>lua require(\"memento\").toggle()<CR>",  { noremap = true, silent = true })

--==============================================================================
-- sindrets/diffview.nvim
--==============================================================================
vim.keymap.set("n", "<A-g>", ":DiffviewOpen ",                { noremap = true, silent = true })
vim.keymap.set("n", "<A-G>", "<Cmd>DiffviewRefresh<CR>",      { noremap = true, silent = true })
vim.keymap.set("n", "<A-c>", "<Cmd>DiffviewToggleFiles<CR>",  { noremap = true, silent = true })
vim.keymap.set("n", "<A-]>", "]c",  { noremap = true })     vim.keymap.set("n", "]c", "<Nop>",  { noremap = true })
vim.keymap.set("n", "<A-[>", "[c",  { noremap = true })     vim.keymap.set("n", "[c", "<Nop>",  { noremap = true })

--==============================================================================
-- TODO: gelguy/wilder.nvim
--==============================================================================
local wilder = require("wilder")
wilder.setup({
    modes = { ":", "/", "?" }
})

wilder.set_option("pipeline", {
    wilder.branch(
        wilder.python_file_finder_pipeline({
            file_command = { "fd", "-tf"   },
            dir_command  = { "fd", "-td",  },
            --filters      = { "cpsm_filter" },
            filters      = { "fuzzy_filter", "difflib_sorter" },
        }),
        wilder.cmdline_pipeline({
            language     = "python",
            fuzzy        = 1,
        }),
        wilder.python_search_pipeline({
            pattern      = wilder.python_fuzzy_delimiter_pattern(),
            sorter       = wilder.python_difflib_sorter(),
            engine       = "re",
        })
    ),
})

wilder.set_option("renderer", wilder.popupmenu_renderer(
    wilder.popupmenu_palette_theme({
        highlighter     = { wilder.lua_pcre2_highlighter(), wilder.lua_fzy_highlighter() },
        highlights      = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
        left            = { " ", wilder.popupmenu_devicons() },
        border          = "rounded",
        max_height      = "75%",
        min_height      = 0,
        prompt_position = "top",
        reverse         = 0,
    })
))

--==============================================================================
-- lewis6991/gitsigns.nvim
--==============================================================================
-- TODO: copy sha to system clipboard
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

vim.keymap.set("n", "<A-b>", gitsigns.toggle_current_line_blame,  { noremap = true, silent = true })

--==============================================================================
-- f-person/git-blame.nvim
--==============================================================================
--vim.keymap.set("n", "<A-b>", "<Cmd>GitBlameToggle<CR>",  { noremap = true, silent = true })
--vim.keymap.set("n", "<A-s>", "<Cmd>GitBlameCopySHA<CR>", { noremap = true, silent = true })

--==============================================================================
-- romgrk/barbar.nvim
--==============================================================================
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>",     { noremap = true, silent = true })

vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>",   { noremap = true, silent = true })
vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>",     { noremap = true, silent = true })

vim.keymap.set("n", "<A-w>", "<Cmd>BufferClose<CR>",    { noremap = true, silent = true })
vim.keymap.set("n", "<A-s>", "<Cmd>BufferPick<CR>",     { noremap = true, silent = true })

--==============================================================================
-- hrsh7th/cmp-nvim-lsp
--==============================================================================
local capabilities = require("cmp_nvim_lsp").default_capabilities()

--==============================================================================
-- hrsh7th/nvim-cmp
--==============================================================================
local cmp = require("cmp")
cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      --["<Esc>"]     = cmp.mapping.abort(),
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
    sources = cmp.config.sources( {
        { name = "nvim_lsp" },
        { name = "luasnip"  }
    },
    {
        { name = "buffer"  }
    })
})

--==============================================================================
-- akinsho/toggleterm.nvim
--==============================================================================
vim.opt.hidden          = true
require("toggleterm").setup({
    open_mapping        = "<A-`>",
    direction           = "float",
    float_opts          = {
        border          = "curved",
        width           = function() return vim.o.columns * 0.8 end,
    }
})

--==============================================================================
-- williamboman/mason.nvim
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

vim.keymap.set("n", "<A-m>", "<Cmd>Mason<CR>", { noremap = true })

--==============================================================================
-- williamboman/mason-lspconfig.nvim
--==============================================================================
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function(server_name)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities
        }
    end,
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" }
                    }
                }
            }
        }
    end,
}

--==============================================================================
-- TODO: neovim/nvim-lspconfig
--==============================================================================
vim.keymap.set("n",          "<Leader>q", vim.diagnostic.open_float, { noremap = true })
vim.keymap.set("n",          "<Leader>[", vim.diagnostic.goto_prev,  { noremap = true })
vim.keymap.set("n",          "<Leader>]", vim.diagnostic.goto_next,  { noremap = true })
vim.keymap.set("n",          "<Leader>o", vim.diagnostic.setloclist, { noremap = true })

vim.keymap.set("n",          "<A-u>",     vim.lsp.buf.declaration,   { noremap = true })
vim.keymap.set("n",          "<A-y>",     vim.lsp.buf.definition,    { noremap = true })
vim.keymap.set("n",          "<A-q>",     vim.lsp.buf.hover,         { noremap = true })
vim.keymap.set("n",          "<Leader>l", vim.lsp.buf.references,    { noremap = true })
vim.keymap.set("n",          "<Leader>r", vim.lsp.buf.rename,        { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>a", vim.lsp.buf.code_action,   { noremap = true })
