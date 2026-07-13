return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
	},
	config = function()
		-- Setup servers
		-- local cmp_nvim_lsp = require("cmp_nvim_lsp")
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- blink cmp
		capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

		-- Global LSP settings (applied to all servers)
		vim.lsp.config("*", {
			capabilities = capabilities,
		})
	end,
}
