---@type vim.lsp.Config
return {
	cmd = { "ruff", "server" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"ruff.toml",
		".ruff.toml",
		".git",
	},
	init_options = {
		settings = {
			logLevel = "debug",
			fixAll = true,
			organizeImports = true,
			lint = {
				ignore = {
					"F401",
					"F841",
					"F541",
				},
			},
		},
	},
}
