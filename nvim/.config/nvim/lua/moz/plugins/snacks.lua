--@module 'snacks'
return {
	-- HACK: docs @ https://github.com/folke/snacks.nvim/blob/main/docs
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		-- NOTE: Options
		opts = {
			styles = {
				input = {
					keys = {
						n_esc = { "<Esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
						i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
					},
				},
			},
			-- bigfile
			bigfile = { enabled = false },
			-- Snacks Modules
			input = {
				enabled = true,
			},
			quickfile = {
				enabled = true,
				exclude = { "latex" },
			},
			-- HACK: read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
			picker = {
				sources = {},
				enabled = true,
				matcher = {
					frecency = true,
					cwd_bonus = false,
				},
				exclude = {
					".git",
					"node_modules",
					"dist",
					"build",
				},
				formatters = {
					file = {
						filename_first = true,
						filename_only = false,
						icon_width = 2,
					},
				},
				layout = {
					-- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
					-- override picker layout in keymaps function as a param below
					preset = "telescope", -- defaults to this layout unless overidden
					cycle = false,
				},
				layouts = {
					searchy = {
						layout = {
							backdrop = false,
							row = 1,
							width = 0.6,
							min_width = 80,
							height = 0.9,
							border = "none",
							box = "vertical",
							{
								win = "preview",
								wo = {
									number = false,
								},
								title = "Grep Preview",
								height = 0.4,
								border = "rounded",
							},
							{
								box = "vertical",
								border = true,
								title = "{title} {live} {flags}",
								title_pos = "center",
								{ win = "input", height = 1, border = "bottom" },
								{ win = "list", border = "none" },
							},
						},
					},
					telescope = {
						reverse = true, -- set to false for search bar to be on top
						layout = {
							box = "horizontal",
							backdrop = false,
							width = 0.9,
							height = 0.9,
							border = "none",
							{
								box = "vertical",
								{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
								{
									win = "input",
									height = 1,
									border = "rounded",
									title = "{title} {live} {flags}",
									title_pos = "center",
								},
							},
							{
								win = "preview",
								title = "{preview:Preview}",
								width = 0.50,
								border = "rounded",
								title_pos = "center",
							},
						},
					},
					ivy = {
						layout = {
							box = "vertical",
							backdrop = false,
							width = 0,
							height = 0.4,
							position = "bottom",
							border = "top",
							title = " {title} {live} {flags}",
							title_pos = "left",
							{ win = "input", height = 1, border = "bottom" },
							{
								box = "horizontal",
								{ win = "list", border = "none" },
								{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
							},
						},
					},
				},
			},
			image = {
				enabled = function()
					return vim.bo.filetype == "markdown"
				end,
				doc = {
					float = false, -- show image on cursor hover
					inline = false, -- show image inline
					max_width = 100,
					max_height = 70,
					wo = {
						wrap = false,
					},
				},
				convert = {
					notify = true,
					command = "magick",
				},
				img_dirs = {
					"img",
					"images",
					"assets",
					"static",
					"public",
					"media",
					"attachments",
					"Archives/All-Vault-Images/",
					"~/Library",
					"~/Downloads",
				},
			},
			dashboard = {
				enabled = true,
				preset = {
					header = [[
 ⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⢀⠀⡀⡀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀
 ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣽⠃⠀⠀⠀⢼⠻⣿⣿⣟⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
 ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠛⡶⢶⢺⠁⠀⠈⢿⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⣿
 ⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣤⠀⣀⣠⡛⣣⡀⠀⠈⢿⣿⣿⣻⣏⣿⣿⣿⣿⣿⣿⣟⣿⠿
 ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⣳⣶⣿⣿⣷⣾⠱⠀⠀⠊⢿⠿⠿⢛⣽⣿⡿⢿⣿⣟⠿⠿⠿
 ⠉⠉⠉⠛⠛⠛⠋⠛⠛⠛⣧⠀⡀⠀⠀⢿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠅⢀⢀⡀
 ⠔⠄⢀⡀⠀⠀⠀⠄⠐⠸⠿⡀⠀⠀⠀⢘⣿⢷⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠰⣠⣇
 ⣷⣆⣴⣮⢻⡲⡲⠀⠁⠀⠀⠀⠀⠀⠀⠹⡿⠘⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣀⡘⢷⣏
 ⣿⣿⣿⣗⠿⢈⠁⡀⠀⠁⠀⠀⠀⠀⠀⠀⠉⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⠄⠀⠄⠈⢿⣮⢿
 ⣿⣟⡿⣾⠀⠀⠀⠀⠀⠀⠀⢀⡤⠄⠀⠀⠀⠀⠸⠁⢠⣦⣤⢀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠈⣿⠀
 ⣿⣿⠏⠁⢀⡇⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠘⡏⣷⣵⡻⠃⠄⢴⣆⠀⠀⠀⠀⠀⠀⠀⠰⠀⣆⣷⣿
 ⣿⡿⣻⠗⠀⢠⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢠⣤⣄⢰⣶⢯⣤⡈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⣿⣼
                    ]],
					keys = {
						{
							icon = " ",
							key = "f",
							desc = "Find File",
							action = function()
								require("fff").find_files()
							end,
						},
						{
							icon = " ",
							key = "n",
							desc = "Notes",
							action = function()
								require("fff").find_files_in_dir("~/dev/Notes/")
							end,
						},
						{
							icon = "  ",
							key = "p",
							desc = "Projects",
							action = ":lua Snacks.picker.projects()",
						},
						{
							icon = " ",
							key = "s",
							desc = "Find Text",
							action = ":lua Snacks.dashboard.pick('live_grep')",
						},
						{
							icon = " ",
							key = "r",
							desc = "Recent Files",
							action = ":lua Snacks.dashboard.pick('oldfiles')",
						},
						{
							icon = " ",
							key = "c",
							desc = "Config",
							action = function()
								require("fff").find_files_in_dir("~/.config/nvim")
							end,
						},
						{
							icon = " ",
							key = "g",
							desc = "Restore Session",
							section = "session",
						},
						{
							icon = "󰒲 ",
							key = "L",
							desc = "Lazy",
							action = ":Lazy",
							enabled = package.loaded.lazy ~= nil,
						},
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				formats = {
					-- file = function(item, ctx)
					-- 	local name = vim.fn.fnamemodify(item.file, ":t") -- just the last folder name
					-- 	return { { name, hl = "SnacksDashboardFile" } }
					-- end,
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "startup" },
				},
			},
		},
		-- NOTE: Keymaps
		keys = {
			{
				"<leader>rn",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Fast Rename Current File",
			},
			{
				"<leader>dB",
				function()
					require("snacks").bufdelete()
				end,
				desc = "Delete or Close Buffer  (Confirm)",
			},

			-- Snacks Picker
			{
				"<leader>ff",
				function()
					require("snacks").picker.files()
				end,
				desc = "Find Files (Snacks Picker)",
			},
			{
				"<leader>fc",
				function()
					require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/" })
				end,
				desc = "Find Config File",
			},
			{
				"<leader>fn",
				function()
					require("snacks").picker.files({
						cwd = "~/dev/Notes/",
					})
				end,
				desc = "Notes",
			},
			{
				"<leader>fs",
				function()
					require("snacks").picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>fw",
				function()
					require("snacks").picker.grep_word()
				end,
				desc = "Search Visual selection or Word",
				mode = { "n", "x" },
			},
			{
				"<leader>fk",
				function()
					require("snacks").picker.keymaps()
				end,
				desc = "Search Keymaps (Snacks Picker)",
			},
			{
				"<leader>fp",
				function()
					require("snacks").picker.projects()
				end,
				desc = "Projects",
			},
			{
				"<leader>fb",
				function()
					require("snacks").picker.buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fr",
				function()
					require("snacks").picker.recent()
				end,
				desc = "Recent",
			},

			-- Git Stuff
			{
				"<leader>gg",
				function()
					require("snacks").picker.git_branches({ layout = "select" })
				end,
				desc = "Pick and Switch Git Branches",
			},

			-- Other Utils
			{
				"<leader>th",
				function()
					require("snacks").picker.colorschemes({ layout = "ivy" })
				end,
				desc = "Pick Color Schemes",
			},
			{
				"<leader>vp",
				function()
					require("snacks").picker.help()
				end,
				desc = "Help Pages",
			},

			-- LSP
			{
				"gd",
				function()
					require("snacks").picker.lsp_definitions()
				end,
				desc = "Goto Definition",
			},
			{
				"gD",
				function()
					require("snacks").picker.lsp_declarations()
				end,
				desc = "Goto Declaration",
			},
			{
				"<leader>grr",
				function()
					require("snacks").picker.lsp_references()
				end,
				nowait = true,
				desc = "References",
			},
			{
				"gi",
				function()
					require("snacks").picker.lsp_implementations()
				end,
				desc = "Goto Implementation",
			},
			{
				"gy",
				function()
					require("snacks").picker.lsp_type_definitions()
				end,
				desc = "Goto T[y]pe Definition",
			},
			{
				"gai",
				function()
					Snacks.picker.lsp_incoming_calls()
				end,
				desc = "C[a]lls Incoming",
			},
			{
				"gao",
				function()
					Snacks.picker.lsp_outgoing_calls()
				end,
				desc = "C[a]lls Outgoing",
			},
			{
				"<leader>sd",
				function()
					require("snacks").picker.diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>sb",
				function()
					require("snacks").picker.diagnostics_buffer()
				end,
				desc = "Buffer Diagnostics",
			},
			{
				"<leader>sq",
				function()
					require("snacks").picker.qflist()
				end,
				desc = "Quickfix List",
			},
			{
				"<leader>s;",
				function()
					require("snacks").picker.marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>sp",
				function()
					require("snacks").picker.loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>sr",
				function()
					require("snacks").picker.registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>ss",
				function()
					Snacks.picker.lsp_symbols({ tree = false })
				end,
				desc = "LSP Symbols",
			},
			{
				"<leader>sw",
				function()
					Snacks.picker.lsp_workspace_symbols()
				end,
				desc = "LSP Workspace Symbols",
			},
			{
				"<leader>o",
				function()
					require("snacks").picker.lines({
						layout = {
							preset = "searchy",
							preview = true,
						},
						title = "Current Buffer Fuzzy",
					})
				end,
				desc = "Current Buffer Fuzzy",
			},
		},
	},
}
