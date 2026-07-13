return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		local eslint = lint.linters.eslint_d

		-- if Eslint error configuration not found : change MasonInstall eslint@version or npm i -g eslint at a specific version
		lint.linters_by_ft = {
			javascript = { "biomejs" },
			typescript = { "biomejs" },
			javascriptreact = { "biomejs" },
			typescriptreact = { "biomejs" },
			svelte = { "biomejs" },
			python = { "ruff" },
		}

		eslint.args = {
			"--no-warn-ignored",
			"--format",
			"json",
			"--stdin",
			"--stdin-filename",
			function()
				return vim.fn.expand("%:p")
			end,
		}

		-- Configure ruff with custom ignore rules
		-- local ruff = lint.linters.ruff
		-- ruff.args = {
		-- 	"check",
		-- 	"--force-exclude",
		-- 	"--quiet",
		-- 	"--stdin-filename",
		-- 	function()
		-- 		return vim.api.nvim_buf_get_name(0)
		-- 	end,
		-- 	"--output-format=json",
		-- 	"--ignore=F401,F821,E402,E722,E712,N", -- Your ignore rules
		-- 	"-",
		-- }

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
