return {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--header-insertion=iwyu",
		"--fallback-style=LLVM",
	},
	filetypes = { "c", "cpp", "objc", "objcpp" },
}
