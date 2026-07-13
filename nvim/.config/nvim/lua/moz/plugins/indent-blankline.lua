return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {
		enabled = true,
		indent = {
			-- char = "│",
			char = "▏",

			highlight = { "IblIndent" },
		},
		scope = {
			enabled = false,
			show_start = true,
			show_end = true,
			highlight = { "IblScope" },
		},
		exclude = {
			filetypes = {
				"help",
				"dashboard",
				"lazy",
				"markdown",
			},
		},
	},
}
