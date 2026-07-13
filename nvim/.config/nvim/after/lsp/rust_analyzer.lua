return {
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
			checkOnSave = true,
			check = {
				command = "clippy",
			},

			-- rustfmt = {
			-- 	extraArgs = { "--edition", "2021" },
			-- },
		},
	},
}
