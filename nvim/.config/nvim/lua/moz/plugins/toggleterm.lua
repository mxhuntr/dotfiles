return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			direction = "float",

			cwd = function()
				return vim.fn.getcwd()
			end,

			float_opts = {
				border = "curved",
				width = function()
					return math.floor(vim.o.columns * 0.9)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			},

			start_in_insert = true,
			persist_size = true,
		})

		-- Create isolated terminal instance per neovim window
		local Terminal = require("toggleterm.terminal").Terminal
		local float_term = nil

		-- Generic toggle for empty terminal
		vim.keymap.set("n", "<leader>tt", function()
			if not float_term or not float_term:is_open() then
				float_term = Terminal:new({
					direction = "float",
					cwd = vim.fn.getcwd(),
					float_opts = {
						border = "curved",
						width = math.floor(vim.o.columns * 0.9),
						height = math.floor(vim.o.lines * 0.9),
					},
				})
			end

			float_term:toggle()
		end, { desc = "Toggle 90% floating terminal" })

		-- Helper function to run commands in the floating terminal
		local function run_in_float(cmd)
			if not float_term or not float_term:is_open() then
				float_term = Terminal:new({
					cmd = cmd,
					direction = "float",
					close_on_exit = true,
					float_opts = {
						border = "curved",
						width = math.floor(vim.o.columns * 0.9),
						height = math.floor(vim.o.lines * 0.9),
					},
				})
			else
				float_term.cmd = cmd
			end
			float_term:toggle()
		end

		-- C file: compile + run
		vim.keymap.set("n", "<leader>tc", function()
			local file_path = vim.fn.expand("%:.")
			local file_name = vim.fn.expand("%:t:r")
			local cmd = string.format(
				"clear && clang -std=c99 -Wall -Wextra -Werror -fsanitize=address %s -o %s && ./%s ; exec $SHELL",
				file_path,
				file_name,
				file_name
			)
			run_in_float(cmd)
		end, { desc = "Compile & run C file" })

		-- C++ file: compile + run
		vim.keymap.set("n", "<leader>ts", function()
			local file_path = vim.fn.expand("%:.")
			local file_name = vim.fn.expand("%:t:r")
			local cmd =
				string.format("clear && clang++ %s -o %s && ./%s ; exec $SHELL", file_path, file_name, file_name)
			run_in_float(cmd)
		end, { desc = "Compile & run C++ file" })

		-- Python file: run(native)
		vim.keymap.set("n", "<leader>tp", function()
			local file_path = vim.fn.expand("%:.")
			local cmd = string.format("clear && python3 %s ; exec $SHELL", file_path)
			run_in_float(cmd)
		end, { desc = "Run Python file" })

		-- Python file: run(uv)
		vim.keymap.set("n", "<leader>tu", function()
			local file_path = vim.fn.expand("%:.")
			local cmd = string.format("clear && uv run %s ; exec $SHELL", file_path)
			run_in_float(cmd)
		end, { desc = "Run Python file" })

		-- Rust file: run
		vim.keymap.set("n", "<leader>tr", function()
			local file_path = vim.fn.expand("%:.")
			local cmd = string.format("clear && cargo build && cargo run %s ; exec $SHELL", file_path)
			run_in_float(cmd)
		end, { desc = "Run Rust file" })

		-- Javascript file: run
		vim.keymap.set("n", "<leader>tj", function()
			local file_path = vim.fn.expand("%:.")
			local cmd = string.format("clear && bun run %s ; exec $SHELL", file_path)
			run_in_float(cmd)
		end, { desc = "Run Javascript file" })

		-- Open rmpc
		vim.keymap.set("n", "<leader>\\", function()
			run_in_float("rmpc")
		end, { desc = "Open rmpc" })

		-- Open btop
		vim.keymap.set("n", "<leader>tb", function()
			run_in_float("btop")
		end, { desc = "Open btop" })

		-- Close terminal function
		local function close_float_term()
			if float_term and float_term:is_open() then
				float_term:close()
			end
		end

		-- Normal mode mapping
		vim.keymap.set("n", "<leader>tx", close_float_term, { desc = "Close floating terminal" })

		-- Terminal mode mapping
		vim.keymap.set("t", "<C-\\>", close_float_term, { desc = "Close floating terminal" })
	end,
}
