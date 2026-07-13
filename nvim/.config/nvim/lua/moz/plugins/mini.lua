return {
	-- HACK: Bracket Function
	{
		"nvim-mini/mini.bracketed",
		config = function()
			require("mini.bracketed").setup({})
		end,
	},
	-- HACK: Comments
	{
		"nvim-mini/mini.comment",
		version = false,
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			require("mini.comment").setup({
				options = {
					custom_commentstring = function()
						local ok, cs = pcall(
							require("ts_context_commentstring.internal").calculate_commentstring,
							{ key = "commentstring" }
						)
						return (ok and cs) or vim.bo.commentstring
					end,
				},
			})
		end,
	},
	-- HACK: File explorer (this works properly with oil unlike nvim-tree)
	{
		"nvim-mini/mini.files",
		config = function()
			local MiniFiles = require("mini.files")
			MiniFiles.setup({
				mappings = {
					go_in = "<CR>", -- Map both Enter and L to enter directories or open files
					go_in_plus = "l",
					go_out = "-",
					go_out_plus = "h",
				},
				windows = {
					-- Maximum number of windows to show side by side
					max_number = math.huge,
					-- Whether to show preview of file/directory under cursor
					preview = true,
					-- Width of focused window
					width_focus = 50,
					-- Width of non-focused window
					width_nofocus = 15,
					-- Width of preview window
					width_preview = 100,
				},
			})
			vim.keymap.set("n", "<leader>ee", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" }) -- toggle file explorer
			vim.keymap.set("n", "<leader>ef", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
				MiniFiles.reveal_cwd()
			end, { desc = "Toggle into currently opened file" })
		end,
	},
	-- HACK: Surround
	{
		"nvim-mini/mini.surround",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- Add custom surroundings to be used on top of builtin ones. For more
			-- information with examples, see `:h MiniSurround.config`.
			custom_surroundings = nil,

			-- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
			highlight_duration = 300,

			-- Module mappings. Use `''` (empty string) to disable one.
			-- INFO:
			-- saiw surround with no whitespace
			-- saw surround with whitespace
			mappings = {
				add = "ma", -- Add surrounding in Normal and Visual modes
				delete = "ms", -- Delete surrounding
				find = "mf", -- Find surrounding (to the right)
				find_left = "mF", -- Find surrounding (to the left)
				highlight = "mh", -- Highlight surrounding
				replace = "mr", -- Replace surrounding
				update_n_lines = "mn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},

			-- Number of lines within which surrounding is searched
			n_lines = 20,

			-- Whether to respect selection type:
			-- - Place surroundings on separate lines in linewise mode.
			-- - Place surroundings on each line in blockwise mode.
			respect_selection_type = false,

			-- How to search for surrounding (first inside current line, then inside
			-- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
			-- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
			-- see `:h MiniSurround.config`.
			search_method = "cover",

			-- Whether to disable showing non-error feedback
			silent = false,
		},
	},
	-- HACK: Get rid of whitespace
	{
		"nvim-mini/mini.trailspace",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local miniTrailspace = require("mini.trailspace")

			miniTrailspace.setup({
				only_in_normal_buffers = true,
			})
			vim.keymap.set("n", "<leader>cw", function()
				miniTrailspace.trim()
			end, { desc = "Erase Whitespace" })

			-- Ensure highlight never reappears by removing it on CursorMoved
			vim.api.nvim_create_autocmd("CursorMoved", {
				pattern = "*",
				callback = function()
					require("mini.trailspace").unhighlight()
				end,
			})
		end,
	},
	-- HACK: Split & join
	{
		"nvim-mini/mini.splitjoin",
		config = function()
			local miniSplitJoin = require("mini.splitjoin")
			miniSplitJoin.setup({
				mappings = { toggle = "" }, -- Disable default mapping
			})
			vim.keymap.set({ "n", "x" }, "<leader>sj", function()
				miniSplitJoin.join()
			end, { desc = "Join arguments" })
			vim.keymap.set({ "n", "x" }, "<leader>sk", function()
				miniSplitJoin.split()
			end, { desc = "Split arguments" })
		end,
	},
	-- HACK: Icons
	{
		"nvim-mini/mini.icons",
		-- lazy = false,
		config = function()
			require("mini.icons").setup({
				default = {
					-- file = { hl = "MiniIconsGrey" },
					-- filetype = { hl = "MiniIconsGrey" },
					-- extension = { hl = "MiniIconsGrey" },
					-- directory = { hl = "MiniIconsGrey" },
					-- lsp = { hl = "MiniIconsGrey" },
					-- os = { hl = "MiniIconsGrey" },
				},
				extension = {},
				file = {
					-- ["README.md"] = { glyph = "", hl = "MiniIconsGrey" },
				},
				filetype = {
					-- python = { glyph = "󰌠", hl = "MiniIconsGrey" }, -- filetype name
					-- rust = { glyph = "󱘗", hl = "MiniIconsGrey" },
					-- toml = { glyph = "", hl = "MiniIconsGrey" },
					-- markdown = { glyph = "󰍔", hl = "MiniIconsGrey" },
				},
			})
		end,
	},
	-- HACK: Textobjects
	{
		"nvim-mini/mini.ai",
		config = function()
			require("mini.ai").setup()
		end,
	},
	-- HACK: Ezzy Operators
	{
		"nvim-mini/mini.operators",
		config = function()
			require("mini.operators").setup()
		end,
	},
	-- HACK: Auto Pair
	{
		"nvim-mini/mini.pairs",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	-- HACK: Git Diff
	{
		"nvim-mini/mini.diff",
		config = function()
			require("mini.diff").setup({
				view = {
					style = vim.go.number and "sign",
					signs = { add = "", change = "", delete = "" },
				},
			})
		end,
	},
	-- HACK: Indent Animation
	{
		"nvim-mini/mini.indentscope",
		config = function()
			require("mini.indentscope").setup({
				draw = {
					delay = 100,
				},
				-- symbol = "│",
				symbol = "▏",
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "help", "dashboard", "lazy", "mason", "notify", "markdown" },
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
}
