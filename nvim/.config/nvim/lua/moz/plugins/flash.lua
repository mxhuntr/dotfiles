return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		highlight = {
			backdrop = true,
		},
		modes = {
			search = {
				enabled = false,
			},
		},
	},
	config = function(_, opts)
		require("flash").setup(opts)

		-- Reverse Void
		-- vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#7EABF2", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#000000", bg = "#50C878", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#000000", bg = "#ffcc00", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#555555" })

		-- Catppuccin
		-- vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#000000", bg = "#f38ba8", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#000000", bg = "#a6e3a1", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#b4befe", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffcc00", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#a6e3a1", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#b4befe", bold = true })

		-- Vague
		-- vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#000000", bg = "#ffcc00", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#000000", bg = "#d8647e", bold = true })
		-- vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#000000", bg = "#ffffff", bold = true })

		-- Koda
		vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ffcc00", bold = true })
		vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#d8647e", bold = true })
		vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#ffffff", bold = true })
	end,
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function()
				require("flash").treesitter_search()
			end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				require("flash").toggle()
			end,
			desc = "Toggle Flash Search",
		},
	},
}
