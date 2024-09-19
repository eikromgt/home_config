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
vim.opt.splitkeep       = "screen"

vim.opt.ignorecase      = true
vim.opt.smartcase       = true
vim.opt.display         = "uhex"

vim.opt.clipboard:append("unnamedplus")
vim.opt.fillchars:append({ eob = " ", diff = " " })
vim.api.nvim_create_autocmd("BufEnter",  { callback = function() vim.opt.formatoptions = vim.opt.formatoptions - { "c","r","o" } end })

--==============================================================================
-- Global Variables
--==============================================================================
PluginPath      = vim.fn.stdpath("data") .. "/lazy"
CodePath        = "~/.config/Code"
CodeSnippets    = CodePath .. "/User/snippets/common.code-snippets"

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
vim.keymap.set("n", "<A-S-.>", "<C-w>>", { noremap = true })     vim.keymap.set("n", "<C-w>>", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-,>", "<C-w><", { noremap = true })     vim.keymap.set("n", "<C-w><", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-=>", "<C-w>+", { noremap = true })     vim.keymap.set("n", "<C-w>+", "<Nop>", { noremap = true })
vim.keymap.set("n", "<A-S-->", "<C-w>-", { noremap = true })     vim.keymap.set("n", "<C-w>-", "<Nop>", { noremap = true })

vim.keymap.set("n", "<A-a>",   "<Cmd>%!xxd<CR>",       { noremap = true })
vim.keymap.set("n", "<A-S-a>",   "<Cmd>%!xxd -r<CR>",    { noremap = true })

vim.keymap.set("n", "<A-p>",   ":e ",                   { noremap = true })
vim.keymap.set("n", "<A-z>",   ":vertical help ",       { noremap = true })

-- copy current filepath to system clipboard
vim.keymap.set("n", "<Leader>f", function()
        local filepath = vim.api.nvim_buf_get_name(0)

        vim.fn.setreg("+", filepath)
        print("copy filepath: " .. filepath)
    end, { noremap = true, silent = true })

-- copy current line git commit hash to system clipboard
vim.keymap.set("n", "<Leader>s", function()
        local filepath = vim.api.nvim_buf_get_name(0)
        local line = vim.api.nvim_win_get_cursor(0)[1]

        local sha = vim.fn.system("git blame -sp -L " .. line .. "," .. line .. " "..  filepath .. " | head -n1 | cut -d ' ' -f 1")
        vim.fn.setreg("+", sha)
        print(filepath .. ":" .. line .. " " .. sha)
    end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(_)
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
    end,
})

--==============================================================================
-- Plugin Manager: folke/lazy.nvim
--==============================================================================
local lazypath = PluginPath .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)
vim.keymap.set("n", "<A-x>", "<Cmd>Lazy<CR>", { noremap = true })

require("lazy").setup({
    -- Editor
    { "vim-scripts/ReplaceWithRegister"                                     },
    { "smoka7/hop.nvim",          version  = "*", config = true             },
    { "windwp/nvim-autopairs",    event    = "InsertEnter", config = true   },
    { "Pocco81/auto-save.nvim"                                              },

    -- Decoration
    { "ellisonleao/gruvbox.nvim", priority = 1000                           },
    { "RRethy/vim-illuminate"                                               },
    { "nvimdev/hlsearch.nvim",    event = "BufRead", config = true          },
    { "HiPhish/rainbow-delimiters.nvim"                                     },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"                },

    -- Window
    { "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }                    },
    { "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }                    },
    { "romgrk/barbar.nvim", dependencies = { "nvim-tree/nvim-web-devicons",
        "lewis6991/gitsigns.nvim"}                                          },

    -- Tool
    { "nvim-telescope/telescope.nvim", config = true, branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" }                          },
    { "nixprime/cpsm",            build = "./install.sh"                    },
    { "gelguy/wilder.nvim", dependencies = {
        "roxma/nvim-yarp", "romgrk/fzy-lua-native" }                        },
    { "akinsho/toggleterm.nvim",  version  = "*", config = true             },
    { "stevearc/overseer.nvim", dependencies = {
        "nvim-telescope/telescope.nvim", "akinsho/toggleterm.nvim" }        },
    { "jemag/telescope-diff.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" }                  },

    -- Git
    { "sindrets/diffview.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" }                    },
    { "lewis6991/gitsigns.nvim"                                             },

    -- Completion
    { "L3MON4D3/LuaSnip", version  = "2.*", build = "make install_jsregexp" },
    { "hrsh7th/cmp-nvim-lsp"                                                },
    { "hrsh7th/cmp-buffer"                                                  },
    { "hrsh7th/cmp-path"                                                    },
    { "hrsh7th/nvim-cmp",
        dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" }     },
    { "saadparwaiz1/cmp_luasnip",
        dependencies = { "L3MON4D3/LuaSnip", "hrsh7th/nvim-cmp" }           },

    -- LSP
    { "williamboman/mason.nvim"                                             },
    { "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" }},
    { "neovim/nvim-lspconfig"                                               },

    -- DAP
    { "mfussenegger/nvim-dap"                                               },
    { "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}   },
})

--==============================================================================
-- smoka7/hop.nvim
--==============================================================================
local hop = require("hop")
local directions = require("hop.hint").HintDirection

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
    execution_message = { message = "" },
    debounce_delay = 1000,
})

--==============================================================================
-- ellisonleao/gruvbox.nvim
--==============================================================================
require("gruvbox").setup({
    transparent_mode    = true,
})
vim.cmd.colorscheme("gruvbox")

--==============================================================================
-- RRethy/vim-illuminate
--==============================================================================
vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })

--==============================================================================
-- nvim-treesitter/nvim-treesitter
--==============================================================================
require("nvim-treesitter.configs").setup({
  ensure_installed = { "c","vim", "vimdoc", "cpp", "lua", "python", "cmake", "glsl", "json", "query" },
  sync_install = false,
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
  indent = {
      enable = true
  },
})

--==============================================================================
-- nvim-tree/nvim-tree.lua
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
vim.keymap.set("", "<A-e>",    "<cmd>NvimTreeFindFileToggle<cr>",   { noremap = true })

--==============================================================================
-- nvim-lualine/lualine.nvim
--==============================================================================
require("lualine").setup({
    options = {
        section_separators = "",
        component_separators = ""
    },
    sections = {
        lualine_a = {},
        lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
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
-- nvim-telescope/telescope.nvim
--==============================================================================
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<A-f>", telescope.live_grep, { noremap = true })
vim.keymap.set("n", "<A-S-f>", function() telescope.grep_string({search = vim.fn.expand("<cword>")}) end, { noremap = true })

--==============================================================================
-- gelguy/wilder.nvim
--==============================================================================
local wilder = require("wilder")
wilder.setup({
    modes       = { ":", "/", "?" },
    interval    = 1000,
})

wilder.set_option("pipeline", {
    wilder.branch(
        wilder.python_file_finder_pipeline({
            file_command = function(_, arg)
                if string.find(arg, '.') ~= nil then
                    return { "fd", "--type", "file", "--fixed-strings", "--unrestricted" }
                else
                    return { "fd", "--type", "file", "--fixed-strings" }
                end
            end,
            dir_command = { "fd", "--type", "directory", "--fixed-strings" },
            filters     = { "cpsm_filter" }
        }),
        wilder.cmdline_pipeline({
            language    = "python",
            fuzzy       = 1
        }),
        wilder.python_search_pipeline({
            pattern     = wilder.python_fuzzy_pattern(),
            sorter      = wilder.python_difflib_sorter(),
            engine      = "re"
        })
        --wilder.vim_search_pipeline()
    )
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
    autochdir           = true,
})

vim.keymap.set("n", "<A-S-`>", "<Cmd>TermSelect<CR>", { noremap = true })

--==============================================================================
-- stevearc/overseer.nvim
--==============================================================================
require("overseer").setup({
    dap         = false,
})

vim.keymap.set("n", "<A-t>", "<Cmd>OverseerRun<CR>", { noremap = true })
vim.keymap.set("n", "<A-S-t>", "<Cmd>OverseerToggle<CR>", { noremap = true })


--==============================================================================
-- jemag/telescope-diff.nvim
--==============================================================================
require("telescope").load_extension("diff")

vim.keymap.set("n", "<A-S-c>", function() require("telescope").extensions.diff.diff_files({ hidden = true }) end,
    { desc = "Compare 2 files" })

vim.keymap.set("n", "<A-c>",   function() require("telescope").extensions.diff.diff_current({ hidden = true }) end,
    { desc = "Compare file with current" })

--==============================================================================
-- sindrets/diffview.nvim
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

vim.keymap.set("n", "<A-g>",   ":DiffviewOpen ",                { noremap = true })
vim.keymap.set("n", "<A-S-g>", ":DiffviewClose<CR>",               { noremap = true })
vim.keymap.set("n", "<A-]>", "]c",  { noremap = true })     vim.keymap.set("n", "]c", "<Nop>",  { noremap = true })
vim.keymap.set("n", "<A-[>", "[c",  { noremap = true })     vim.keymap.set("n", "[c", "<Nop>",  { noremap = true })

--==============================================================================
-- lewis6991/gitsigns.nvim
--==============================================================================
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

--==============================================================================
-- L3MON4D3/LuaSnip
--==============================================================================
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").load_standalone({
    path = CodeSnippets,
    lazy = true
})

--==============================================================================
-- hrsh7th/cmp-nvim-lsp
--==============================================================================
local cmp_nvim_lsp_cap = require("cmp_nvim_lsp").default_capabilities()

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
    sources = cmp.config.sources(
        { { name = "nvim_lsp" }, { name = "luasnip" }, { name = "path" } },
        { { name = "buffer"   }, })
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
require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            require("lspconfig")[server_name].setup {
                capabilities = cmp_nvim_lsp_cap
            }
        end,
        ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup {
                capabilities = cmp_nvim_lsp_cap,
                settings     = {
                    Lua = { diagnostics = { globals = { "vim" } } }
                }
            }
        end,
    }
})

--==============================================================================
-- mfussenegger/nvim-dap
--==============================================================================
local dap = require("dap")
local dap_vscode = require("dap.ext.vscode")

require("overseer").patch_dap(true)

dap_vscode.json_decode = require("overseer.json").decode

dap.adapters.lldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" }
    }
}

vim.keymap.set("n", "<A-d>", function()
        if vim.fn.filereadable(".vscode/launch.json") then
            dap_vscode.load_launchjs(nil, { lldb = { "c", "cpp", "glsl" }})
        end
        require("dap").continue()
    end,          { noremap = true, silent = true })
vim.keymap.set("n", "<A-n>", function() require("dap").step_over() end,         { noremap = true, silent = true })
vim.keymap.set("n", "<A-i>", function() require("dap").step_into() end,         { noremap = true, silent = true })
vim.keymap.set("n", "<A-o>", function() require("dap").step_out() end,          { noremap = true, silent = true })
vim.keymap.set("n", "<A-b>", function() require("dap").toggle_breakpoint() end, { noremap = true, silent = true })

--==============================================================================
-- rcarriga/nvim-dap-ui
--==============================================================================
local dapui = require("dapui")
dapui.setup({
    layouts = {
        {
            elements = {
                { id = "scopes",        size = 0.25 },
                { id = "breakpoints",   size = 0.25 },
                { id = "stacks",        size = 0.25 },
                { id = "watches",       size = 0.25 }
            },
            position = "right",
            size = 40
        },
        {
            elements = {
                { id = "repl",          size = 0.5 },
                { id = "console",       size = 0.5 }
            },
            position = "bottom",
            size = 10
        }
    },
})

dap.listeners.before.attach.dapui_config           = function() dapui.open() end
dap.listeners.before.launch.dapui_config           = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end

