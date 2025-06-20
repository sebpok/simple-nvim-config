return {
    { "L3MON4D3/LuaSnip", keys = {} },
    {
        "github/copilot.vim",
        cmd = "Copilot",
        event = "BufWinEnter",
        init = function()
            vim.g.copilot_no_maps = true
        end,
        config = function()
            -- Block the normal Copilot suggestions
            vim.api.nvim_create_augroup("github_copilot", { clear = true })
            vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
                group = "github_copilot",
                callback = function(args)
                    vim.fn["copilot#On" .. args.event]()
                end,
            })
            vim.fn["copilot#OnFileType"]()
        end,
    },
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "fang2hou/blink-copilot",
        },
        version = "*",
        config = function()
            require("blink.cmp").setup({
                snippets = { preset = "luasnip" },
                signature = { enabled = true },
                appearance = {
                    use_nvim_cmp_as_default = false,
                    nerd_font_variant = "mono",
                },
                sources = {
                    default = { "lsp", "copilot", "path", "snippets", "buffer" },
                    providers = {
                        cmdline = {
                            min_keyword_length = 2,
                        },
                        copilot = {
                            name = "copilot",
                            module = "blink-copilot",
                            score_offset = 0,
                            async = true,
                            opts = {
                                max_suggestions = 1,
                                max_attempts = 1,
                                kind_icon = "",
                                kind_name = "Copilot",
                            }
                        },
                    },
                },
                keymap = {
                    ["<C-f>"] = {},
                    ["<CR>"] = { "accept", "fallback"},
                },
                cmdline = {
                    enabled = false,
                    completion = { menu = { auto_show = true } },
                    keymap = {
                        ["<CR>"] = { "accept_and_enter", "fallback" },
                    },
                },
                completion = {
                    menu = {
                        border = "rounded",
                        scrolloff = 2,
                        scrollbar = false,
                        draw = {
                            columns = {
                                { "kind_icon" },
                                { "label" },
                                { "kind" },
                            },
                        },
                    },
                    documentation = {
                        window = {
                            border = nil,
                            scrollbar = false,
                            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
                        },
                        auto_show = true,
                        auto_show_delay_ms = 500,
                    },
                },
            })
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
