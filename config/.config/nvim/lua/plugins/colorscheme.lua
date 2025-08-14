return {
    -- Tokyo Night
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "storm",
                transparent = true,
                terminal_colors = true,
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                    sidebars = "dark",
                    floats = "dark",
                },
                sidebars = { "qf", "help", "NvimTree" },
                day_brightness = 0.3,
                hide_inactive_statusline = false,
                dim_inactive = false,
                lualine_bold = false,
            })
        end,
    },

    -- Nightfox
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                    terminal_colors = true,
                    dim_inactive = false,
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "italic,bold",
                    },
                },
            })
        end,
    },

    -- Sonokai
    {
        "sainnhe/sonokai",
        config = function()
            vim.g.sonokai_style = "atlantis"
            vim.g.sonokai_enable_italic = 1
            vim.g.sonokai_disable_italic_comment = 0
        end,
    },

    -- Auto dark mode
    {
        "f-person/auto-dark-mode.nvim",
        dependencies = { "EdenEast/nightfox.nvim" },
        event = "VeryLazy",
        config = function()
            -- Ensure nightfox is loaded first
            require("nightfox")
            
            require("auto-dark-mode").setup({
                update_interval = 1000,
                set_dark_mode = function()
                    vim.api.nvim_set_option_value("background", "dark", {})
                    vim.cmd("colorscheme nightfox")
                end,
                set_light_mode = function()
                    vim.api.nvim_set_option_value("background", "light", {})
                    vim.cmd("colorscheme dayfox")
                end,
            })
        end,
    },
}
