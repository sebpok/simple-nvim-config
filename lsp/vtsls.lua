return {
    cmd = { "vtsls" },
    init_options = {
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = "/home/sebpok/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
                configNamespace = "typescript",
            }
        }
    },
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
