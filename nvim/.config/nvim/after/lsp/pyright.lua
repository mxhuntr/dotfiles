return {
	settings = {
		pyright = {
			-- disableTaggedHints = true,
			disableOrganizeImports = true,
		},
		python = {
			pythonPath = ".venv/bin/python",
			analysis = {
				ignore = { "*" },
				-- autoSearchPaths = true,
				-- diagnosticMode = "openFilesOnly",
				-- typeCheckingMode = "basic",
				-- useLibraryCodeForTypes = true,
			},
		},
	},
}
