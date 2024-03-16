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
vim.opt.signcolumn      = "number"
vim.opt.wrap            = false
vim.opt.cmdheight       = 0
vim.opt.showmode        = false
vim.opt.list            = true
vim.opt.splitright      = true

vim.opt.clipboard:append("unnamedplus")
vim.opt.fillchars:append({ eob = " " })
vim.api.nvim_create_autocmd("BufEnter",  { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

--==============================================================================
-- Keyboard Shortcuts and Mappings
--==============================================================================
vim.keymap.set("n", "<Space>", "<Nop>",  { noremap = true })
vim.g.mapleader         = " "

vim.keymap.set("n", "<A-v>",   "<C-v>",  { noremap = true })     vim.keymap.set("n", "<C-v>",  "<Nop>", { noremap = true })
vim.keymap.set("",  "<C-H>",   "<C-w>",  { noremap = true })

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

vim.keymap.set("n", "<A-p>",   ":e ",             { noremap = true })
vim.keymap.set("n", "<A-z>",   ":vertical help ", { noremap = true })

--==============================================================================
-- Plugin Manager: folke/lazy.nvim
--==============================================================================
local plugin_path = vim.fn.stdpath("data") .. "/lazy"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)
vim.keymap.set("n", "<A-x>", "<Cmd>Lazy<CR>", { noremap = true })

require("lazy").setup({
    -- Editor
    { "vim-scripts/ReplaceWithRegister"                                                           },
    { "phaazon/hop.nvim",         branch   = "v2"                                                 },
    { "windwp/nvim-autopairs",    event    = "InsertEnter", opts = {}                             },
    { "Pocco81/auto-save.nvim"                                                                    },

    -- Decoration
    { "ellisonleao/gruvbox.nvim", priority = 1000                                                 },
    { "nvim-tree/nvim-web-devicons",                                                              },
    { "RRethy/vim-illuminate"                                                                     },
    { "nvimdev/hlsearch.nvim",    event = "BufRead"                                               },

    -- Window
    { "nvim-tree/nvim-tree.lua"                                                                   },
    { "nvim-lualine/lualine.nvim",                                                                },
    { "romgrk/barbar.nvim"                                                                        },

    -- Library
    { "nvim-lua/plenary.nvim"                                                                     },
    { "roxma/nvim-yarp"                                                                           },
    { "nixprime/cpsm",            build = plugin_path .. "/cpsm/install.sh"                       },
    { "romgrk/fzy-lua-native"                                                                     },
    { "nvim-telescope/telescope.nvim", branch = "0.1.x"                                           },

    -- Tool
    { "gelguy/wilder.nvim",       dependencies = { "roxma/nvim-yarp", "romgrk/fzy-lua-native" }   },
    { "akinsho/toggleterm.nvim",  version  = "*",           config = true                         },
    { "gaborvecsei/memento.nvim"                                                                  },
    { "L3MON4D3/LuaSnip",         version      = "2.*"                                            },
    { "stevearc/overseer.nvim"                                                                    },

    -- Git
    { "sindrets/diffview.nvim"                                                                    },
    { "lewis6991/gitsigns.nvim"                                                                   },
    --{ "f-person/git-blame.nvim"                                                                   },

    -- Language
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"                                      },
    { "hrsh7th/cmp-nvim-lsp"                                                                      },
    { "hrsh7th/nvim-cmp"                                                                          },
    { "williamboman/mason.nvim"                                                                   },
    { "williamboman/mason-lspconfig.nvim"                                                         },
    { "neovim/nvim-lspconfig"                                                                     },
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
-- Pocco81/auto-save.nvim
--==============================================================================
require("auto-save").setup({
    execution_message = { message = "" }
})

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
-- RRethy/vim-illuminate
--==============================================================================
require("illuminate").configure({
    providers = { "regex" }
})
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

--==============================================================================
-- nvimdev/hlsearch.nvim
--==============================================================================
require("hlsearch").setup()

--==============================================================================
-- nvim-tree/nvim-tree.lua
--==============================================================================
require("nvim-tree").setup({
    view = {
        signcolumn = "auto"
    },
    renderer = {
        indent_width = 1
    },
    filters = {
        git_ignored = false,
        dotfiles = false
    },
})
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
-- nixprime/cpsm
--==============================================================================
vim.g.ctrlp_match_func = { match = "cpsm#CtrlPMatch" }

--==============================================================================
-- nvim-telescope/telescope.nvim
--==============================================================================
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<A-f>", telescope.live_grep, {})

--==============================================================================
-- TODO: gelguy/wilder.nvim
--==============================================================================
local wilder = require("wilder")
wilder.setup({
    modes       = { ":", "/", "?" },
    interval    = 1000,
})

wilder.set_option("pipeline", {
    wilder.branch(
        wilder.python_file_finder_pipeline({
            file_command = { "fd", "-tf"   },
            dir_command  = { "fd", "-td",  },
            -- filters      = { "cpsm_filter" },
            filters = {'fuzzy_filter', 'difflib_sorter'},
        }),
        wilder.cmdline_pipeline(),
        wilder.python_search_pipeline()
    ),
})

wilder.set_option("renderer", wilder.renderer_mux({
    [":"] = wilder.popupmenu_renderer(
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
    ),
    ["/"] = wilder.wildmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        highlights      = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
    }),
    ["?"] = wilder.wildmenu_renderer({
        highlighter = wilder.basic_highlighter(),
        highlights      = { accent = wilder.make_hl("WilderAccent", "Pmenu", {{ a = 1 }, { a = 1 }, { foreground = "#f4468f" }}), },
    }),
}))

--==============================================================================
-- akinsho/toggleterm.nvim
--==============================================================================
vim.opt.hidden          = true
require("toggleterm").setup({
    open_mapping        = "<A-`>",
    direction           = "float",
    float_opts          = {
        border          = "curved",
        width           = function() return math.floor(vim.o.columns * 0.8 + 0.5) end,
    }
})

--==============================================================================
-- fgaborvecsei/memento.nvim
--==============================================================================
vim.keymap.set("n", "<A-o>", "<Cmd>lua require(\"memento\").toggle()<CR>",  { noremap = true, silent = true })

--==============================================================================
-- TODO: L3MON4D3/LuaSnip
--==============================================================================
local luasnip = require("luasnip")
--vim.keymap.set({"i"},       "<Tab>",   function() luasnip.expand() end, { noremap = false, silent = true })
--vim.keymap.set({"i", "s"},  "<Tab>",   function() luasnip.jump( 1) end, { noremap = false, silent = true })
--vim.keymap.set({"i", "s"},  "<S-Tab>", function() luasnip.jump(-1) end, { noremap = true,  silent = true })
--vim.keymap.set({"i", "s"},  "<A-c>",   function() if luasnip.choice_active() then luasnip.change_choice(1) end end, { noremap = true, silent = true })

--==============================================================================
-- stevearc/overseer.nvim 
--==============================================================================
require("overseer").setup()

vim.keymap.set("n", "<A-t>", "<Cmd>OverseerRun<CR>", { noremap = true })
--==============================================================================
-- sindrets/diffview.nvim
--==============================================================================
vim.keymap.set("n", "<A-g>", ":DiffviewOpen ",                { noremap = true, silent = true })
vim.keymap.set("n", "<A-G>", "<Cmd>DiffviewRefresh<CR>",      { noremap = true, silent = true })
vim.keymap.set("n", "<A-c>", "<Cmd>DiffviewToggleFiles<CR>",  { noremap = true, silent = true })
vim.keymap.set("n", "<A-]>", "]c",  { noremap = true })     vim.keymap.set("n", "]c", "<Nop>",  { noremap = true })
vim.keymap.set("n", "<A-[>", "[c",  { noremap = true })     vim.keymap.set("n", "[c", "<Nop>",  { noremap = true })

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
-- nvim-treesitter/nvim-treesitter
--==============================================================================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c","vim", "vimdoc", "query", "cpp", "lua", "python", "cmake", "glsl", "json" },
  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 5 * 1024 * 1024
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
  },
  indent = {
      enable = true
  },
})

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

