return {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
				disable = { "unused-local", "undefined-global" },
			},
			completion = {
				callSnippet = "Replace",
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
			locale = "en-us",
		},
	},
}
