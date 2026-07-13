local keymap = vim.keymap
-- NOTE: LSP Keybinds
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings
		local opts = { buffer = ev.buf, silent = true }

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer

		opts.desc = "Show documentation for what is under cursor"
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, { desc = "Hover documentation" })
	end,
})

-- Define sign icons for each severity
local severity = vim.diagnostic.severity

vim.diagnostic.config({
	-- signs = {
	-- 	text = {
	--		[severity.ERROR] = " ",
	-- 		[severity.WARN] = " ",
	-- 		[severity.HINT] = "",
	-- 		[severity.INFO] = " ",
	-- 	},
	-- },
	-- virtual_text = true,
	virtual_lines = { current_line = true },
	underline = false,
	update_in_insert = false,
})
