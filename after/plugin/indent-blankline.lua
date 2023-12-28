require("ibl").setup {
    scope = { enabled = true },
    exclude = {
        filetypes = { "dashboard", 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'TelescopePrompt',
            'TelescopeResults', '' },
    }
}
