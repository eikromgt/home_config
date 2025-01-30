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

vim.lsp.set_log_level("off")

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
vim.keymap.set("n", "<A-z>",   ":vertical help ",       { noremap = true })

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
vim.keymap.set("n", "<Leader>ts", function()
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

--==============================================================================
-- Plugin Manager: folke/lazy.nvim
--==============================================================================
local lazypath = PluginPath .. "/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.runtimepath:prepend(lazypath)
vim.keymap.set({ "n" }, "<Leader>x", "<Cmd>Lazy<CR>", { noremap = true })

require("lazy").setup({
    -- Editor
    { "vim-scripts/ReplaceWithRegister"                                     },
    { "smoka7/hop.nvim",          version  = "*", config = true             },
    { "windwp/nvim-autopairs",    event    = "InsertEnter"                  },
    { "Pocco81/auto-save.nvim"                                              },
    { "kylechui/nvim-surround",   version = "*", event = "VeryLazy",        },

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
        dependencies = { "nvim-tree/nvim-web-devicons",
        "yavorski/lualine-macro-recording.nvim"  }                          },
    { "nvimdev/dashboard-nvim", event = "VimEnter",
        dependencies = { "nvim-tree/nvim-web-devicons"  }                   },

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
    { "rcarriga/nvim-notify", opts = { background_colour = "#1d2021" }      },
    { "echasnovski/mini.nvim", version = false                              },

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
    { "b0o/schemastore.nvim"                                                },

    -- LSP
    { "williamboman/mason.nvim"                                             },
    { "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" }},
    { "neovim/nvim-lspconfig"                                               },

    -- DAP
    { "mfussenegger/nvim-dap"                                               },
    { "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"}   },

    -- Application
    { "kawre/leetcode.nvim", build = ":TSUpdate html", lazy = vim.fn.argv()[1] ~= "leetcode",
                dependencies = { "nvim-telescope/telescope.nvim", "MunifTanjim/nui.nvim",
        "nvim-treesitter/nvim-treesitter", "rcarriga/nvim-notify", "nvim-tree/nvim-web-devicons", }},
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
vim.keymap.set({ "n", "v" }, "<Leader>w", "<Cmd>HopWord<CR>",  { noremap = true })
vim.keymap.set({ "n", "v" }, "<Leader>c", "<Cmd>HopChar1<CR>", { noremap = true })

--==============================================================================
-- windwp/nvim-autopairs
--==============================================================================
require("nvim-autopairs").setup({
    enable_bracket_in_quote = false;
})

--==============================================================================
-- Pocco81/auto-save.nvim
--==============================================================================
require("auto-save").setup({
    execution_message = { message = "" },
    debounce_delay = 1000,
})

--==============================================================================
-- kylechui/nvim-surround
--==============================================================================
require("nvim-surround").setup()

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
    ensure_installed = { "c","cpp", "printf", "lua", "vim", "vimdoc", "python",
        "cmake", "glsl", "hjson", "typst", "verilog", "query" },
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

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

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
vim.keymap.set({ "n" }, "<A-e>",    "<Cmd>NvimTreeFindFileToggle<CR>",   { noremap = true })

--==============================================================================
-- nvim-lualine/lualine.nvim
--==============================================================================
require("lualine").setup({
    options = {
        globalstatus = true,
        section_separators = "",
        component_separators = ""
    },
    sections = {
        lualine_a = {},
        lualine_c = { "filename", "macro_recording", "%S" },
        lualine_x = { "overseer", "encoding", "fileformat", "filetype" },
    }
})

--==============================================================================
-- nvimdev/dashboard-nvim
--==============================================================================
require("dashboard").setup({
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.b.minitrailspace_disable = true;
  end
})

--==============================================================================
-- nvim-telescope/telescope.nvim
--==============================================================================
local telescope = require("telescope.builtin")
vim.keymap.set('n', '<leader>ff', telescope.find_files, { noremap = true })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fh', telescope.pickers, { noremap = true })
vim.keymap.set('n', '<leader>fb', telescope.buffers, { noremap = true })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { noremap = true })
vim.keymap.set("n", "<Leader>fw", function() telescope.grep_string({search = vim.fn.expand("<cword>")}) end, { noremap = true })

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
                if arg[1] == "." then
                    return { "fd", "--type", "file", "--fixed-strings", "--unrestricted" }
                else
                    return { "fd", "--type", "file", "--fixed-strings" }
                end
            end,
            dir_command = { "fd", "--type", "directory", "--fixed-strings" },
            filters     = { "cpsm_filter" }
        }),
        wilder.substitute_pipeline({
            pipeline    = wilder.python_search_pipeline({
                skip_cmdtype_check  = 1,
                pattern             = wilder.python_fuzzy_pattern({ start_at_boundary = 0, }),
            }),
        }),
        wilder.cmdline_pipeline({
            fuzzy        = 2,
            fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        {
            wilder.check(function(_, x) return x == "" end),
            wilder.history(),
        },
        wilder.python_search_pipeline({
            pattern = wilder.python_fuzzy_pattern({ start_at_boundary = 0, }),
        })
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

vim.keymap.set({ "n", "t" }, "<A-S-`>", "<Cmd>TermSelect<CR>", { noremap = true })

--==============================================================================
-- stevearc/overseer.nvim
--==============================================================================
require("overseer").setup({
    dap = false,
    task_list = {
        min_height = 12,
    }
})

vim.keymap.set({ "n", "t" }, "<A-t>", "<Cmd>OverseerRun<CR>", { noremap = true })
vim.keymap.set({ "n", "t" }, "<A-S-t>", "<Cmd>OverseerToggle<CR>", { noremap = true })

--==============================================================================
-- jemag/telescope-diff.nvim
--==============================================================================
require("telescope").load_extension("diff")

vim.keymap.set("n", "<Leader>fd", function() require("telescope").extensions.diff.diff_files({ hidden = true }) end,
    { desc = "Compare 2 files" })
vim.keymap.set("n", "<Leader>fc",   function() require("telescope").extensions.diff.diff_current({ hidden = true }) end,
    { desc = "Compare file with current" })

--==============================================================================
-- rcarriga/nvim-notify
--==============================================================================
vim.notify = require("notify")
require("telescope").load_extension("notify")
vim.keymap.set({ "n" }, "<Leader>f/", "<Cmd>Telescope notify<CR>", { noremap = true })

--==============================================================================
-- echasnovski/mini.nvim
--==============================================================================
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

vim.keymap.set("n", "<Leader>do",   ":DiffviewOpen",          { noremap = true })
vim.keymap.set("n", "<Leader>dd",   "<Cmd>DiffviewOpen<CR>",  { noremap = true })
vim.keymap.set("n", "<Leader>dc",   "<Cmd>DiffviewClose<CR>", { noremap = true })
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
cmp_nvim_lsp_cap.textDocument.completion.completionItem.snippetSupport = false;

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
        {
            { name = "nvim_lsp", entry_filter = function(entry, _) return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind() end },
            { name = "luasnip" },
            { name = "path" }
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

vim.keymap.set({ "n" }, "<Leader>m", "<Cmd>Mason<CR>", { noremap = true })

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
        ["clangd"] = function()
            require("lspconfig").clangd.setup {
                capabilities = cmp_nvim_lsp_cap,
                init_options = {
                    fallbackFlags = {"--std=c++23"}
                },
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
        ["pylsp"] = function()
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
                    exportPdf = "onType"
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
                { id = "stacks",        size = 0.20 },
                { id = "scopes",        size = 0.35 },
                { id = "watches",       size = 0.30 },
                { id = "breakpoints",   size = 0.10 }
            },
            position = "right",
            size = 60
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

--==============================================================================
-- kawre/leetcode.nvim
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
]]

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

