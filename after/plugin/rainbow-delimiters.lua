-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

local highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
}

vim.g.rainbow_delimiters = {
    strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    highlight = highlight,
}

local hooks = require "ibl.hooks"
require("ibl").setup {
    scope = { highlight = highlight, enabled = true },
    exclude = {
        filetypes = { "dashboard", 'lspinfo', 'packer', 'checkhealth', 'help', 'man', 'gitcommit', 'TelescopePrompt',
            'TelescopeResults', '' },
    }
}


-- -- create the highlight groups in the highlight setup hook, so they are reset
-- -- every time the colorscheme changes
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
--     vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = "#E06C75" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = "#E5C07B" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = "#61AFEF" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterOrange", { fg = "#D19A66" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = "#98C379" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = "#C678DD" })
--     vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = "#56B6C2" })
-- end)
--
-- require("ibl").setup {
--     scope = { highlight = highlight, enabled = true },
--     indent = { highlight = highlight },
-- }
--
-- hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
