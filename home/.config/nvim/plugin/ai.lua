-- AI plugins: copilot.vim (inline suggestions) and minuet-ai.nvim (local FIM
-- completion). Auto-sourced by Neovim at startup (plugin/ files load
-- automatically; lua/ files do not), so they are self-contained here.
vim.pack.add({
    "https://github.com/github/copilot.vim",
    "https://github.com/milanglacier/minuet-ai.nvim",
}, { confirm = false })

--==============================================================================
-- copilot.vim
--==============================================================================
vim.keymap.set("i", "<A-S-a>", 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true

--==============================================================================
-- minuet-ai.nvim
--==============================================================================
local minuet = require("minuet")
local presets = {
    npu = {
        provider = "openai_compatible",
        request_timeout = 30,
        enable_predicates = { function() return true end },
        provider_options = {
            openai_compatible = {
                api_key = function() return "sk-no-key-required" end,
                end_point = "http://127.0.0.1:13305/api/v1/chat/completions",
                model = "qwen3.5-4b-FLM",
                name = "Lemonade NPU",
                optional = {
                    max_tokens = 128,
                    temperature = 0.2,
                    top_p = 0.95,
                    chat_template_kwargs = { enable_thinking = false },
                },
            },
        },
    },
    llama = {
        provider = "openai_fim_compatible",
        request_timeout = 10,
        enable_predicates = { function() return true end },
        provider_options = {
            openai_fim_compatible = {
                api_key = function() return "sk-no-key-required" end,
                end_point = "http://127.0.0.1:8000/v1/completions",
                -- The server selects the model; this template needs Qwen2.5-Coder.
                model = "qwen2.5-coder",
                name = "Llama.cpp",
                optional = {
                    max_tokens = 256,
                    top_p = 0.95,
                    temperature = 0.6,
                },
                template = {
                    prompt = function(context_before_cursor, context_after_cursor, _)
                        return "<|fim_prefix|>"
                            .. context_before_cursor
                            .. "<|fim_suffix|>"
                            .. context_after_cursor
                            .. "<|fim_middle|>"
                    end,
                    suffix = false,
                },
            },
        },
    },
    off = {
        enable_predicates = { function() return false end },
    },
}
minuet.setup {
    virtualtext = {
        auto_trigger_ft = { },
        keymap = {
            accept = "<A-S-Tab>",
        },
    },
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 1024,
    request_timeout = 10,
    throttle = 1000,
    debounce = 500,
    enable_predicates = presets.off.enable_predicates,
    presets = presets,
}

-- A config change during detection takes precedence over the probe results.
local function detect_profile()
    if vim.fn.executable("curl") == 0 then
        vim.notify("Minuet: install curl for automatic server detection.", vim.log.levels.WARN)
        return
    end
    local initial_config = minuet.config
    local results = {}
    local probes = {
        npu = "http://127.0.0.1:13305/api/v1/models",
        llama = "http://127.0.0.1:8000/health",
    }

    for profile, url in pairs(probes) do
        vim.system({ "curl", "--silent", "--fail", "--max-time", "2", url }, { text = true }, function(result)
            vim.schedule(function()
                local ok, body = pcall(vim.json.decode, result.stdout or "")
                local available = false
                if result.code == 0 and ok and type(body) == "table" then
                    if profile == "npu" then
                        for _, model in ipairs(body.data or {}) do
                            if model.id == presets.npu.provider_options.openai_compatible.model
                                and model.downloaded == true then
                                available = true
                            end
                        end
                    else
                        available = body.status == "ok"
                    end
                end
                results[profile] = available
                if results.npu ~= nil and results.llama ~= nil and minuet.config == initial_config then
                    local preset = results.npu and "npu" or results.llama and "llama" or "off"
                    if preset ~= "off" then
                        minuet.change_preset(preset)
                    end
                end
            end)
        end)
    end
end

detect_profile()
