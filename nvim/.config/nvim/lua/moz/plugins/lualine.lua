return {
	{
		"nvim-lualine/lualine.nvim",
		-- dependencies = { "nvim-tree/nvim-web-devicons" },
		dependencies = { "nvim-mini/mini.icons" },
		config = function()
			local lualine = require("lualine")

			--NOTE Reverse Void
			-- local custom_theme = require("lualine.themes.base").get({ style = "light" })
			-- custom_theme.normal.c.fg = "#D73A49"
			-- custom_theme.normal.c.bg = "#B2B2B3" -- "none" for transparent
			-- custom_theme.normal.b.fg = "#ff6600"
			-- custom_theme.normal.b.bg = "#FFF5EE"
			-- custom_theme.inactive = {
			-- 	a = { fg = "#000000", bg = "#B2B2B3" },
			-- 	b = { fg = "#000000", bg = "#B2B2B3" },
			-- 	c = { fg = "#000000", bg = "#B2B2B3" },
			-- }
			local c = require("koda").get_palette("dark")

			-- local custom_theme = {
			-- 	normal = {
			-- 		a = { bg = c.fg, fg = c.bg, gui = "bold" },
			-- 		b = { bg = c.bg, fg = c.fg },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- 	insert = {
			-- 		a = { bg = c.string, fg = c.bg, gui = "bold" },
			-- 		b = { bg = c.bg, fg = c.string },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- 	visual = {
			-- 		a = { bg = c.func, fg = c.bg, gui = "bold" },
			-- 		b = { bg = c.bg, fg = c.func },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- 	replace = {
			-- 		a = { bg = c.const, fg = c.bg, gui = "bold" },
			-- 		b = { bg = c.bg, fg = c.const },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- 	command = {
			-- 		a = { bg = c.special, fg = c.bg, gui = "bold" },
			-- 		b = { bg = c.bg, fg = c.special },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- 	inactive = {
			-- 		a = { bg = c.line, fg = c.fg },
			-- 		b = { bg = c.line, fg = c.fg },
			-- 		c = { bg = c.line, fg = c.fg },
			-- 	},
			-- }

			local custom_theme = {
				normal = {
					a = { bg = none, fg = c.fg, gui = "bold" },
					b = { bg = none, fg = c.fg },
					c = { bg = none, fg = c.fg },
				},
				insert = {
					a = { bg = none, fg = c.string, gui = "bold" },
					b = { bg = none, fg = c.string },
					c = { bg = none, fg = c.string },
				},
				visual = {
					a = { bg = none, fg = c.func, gui = "bold" },
					b = { bg = none, fg = c.func },
					c = { bg = none, fg = c.func },
				},
				replace = {
					a = { bg = none, fg = c.const, gui = "bold" },
					b = { bg = none, fg = c.const },
					c = { bg = none, fg = c.const },
				},
				command = {
					a = { bg = none, fg = c.special, gui = "bold" },
					b = { bg = none, fg = c.special },
					c = { bg = none, fg = c.special },
				},
				inactive = {
					a = { bg = c.line, fg = c.fg },
					b = { bg = c.line, fg = c.fg },
					c = { bg = c.line, fg = c.fg },
				},
			}

			lualine.setup({
				icons_enabled = true,
				options = {
					theme = custom_theme,
					-- theme = "auto",
					-- section_separators = { left = "", right = "" },
					-- component_separators = { left = "", right = "" },
					section_separators = { left = "◣", right = "◢" },
					component_separators = { left = "◣", right = "◢" },
				},
				sections = {
					lualine_a = { "mode" },
					lualine_b = { "branch" },
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
					lualine_y = { "diagnostics" },
					lualine_z = { "location" },
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { "filename" },
					lualine_x = { "location" },
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
	{ "vimpostor/vim-tpipeline" },
}
