return {
	-- NOTE: Koda
	{
		"oskarnurm/koda.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("koda").setup({
				transparent = true, -- enable for transparent backgrounds
				theme = {
					dark = "dark",
					light = "light",
				},
				auto = false, -- disable to load ALL available plugin highlights
				cache = true, -- caches the theme for better performance
				styles = {
					functions = { bold = true },
					keywords = {},
					comments = {},
					strings = {},
					constants = {}, -- includes numbers, booleans
				},
				colors = {
					-- string = "#D3D3D3",
					string = "#7393B3",
					emphasis = "#b0b0b0",
					func = "#BC96B0",
					char = "#7AA89F",
					special = "#7AA89F",
					const = "#d4b878",
					-- border = "#b0b0b0",
					border = "#50585d",
					keywords = "#7AA89F",
				},
				on_highlights = function(hl, c)
					hl.MiniIndentscopeSymbol = { fg = "#777777" } -- active scope (was IblScope)
					hl.MiniIndentscopeSymbolOff = { fg = "#2A2A35" } -- inactive indent (was IblIndent)
					hl.IblIndent = { fg = "#2A2A35" }
					hl.IblScope = { fg = "#777777" }
					hl.GitGraphHash = { fg = "#888888" }
					hl.GitGraphTimestamp = { fg = "#888888" }
					hl.GitGraphAuthor = { fg = "#7799bb" }
					hl.GitGraphBranchName = { fg = "#c1c1c1", bold = true }
					hl.GitGraphBranchTag = { fg = "#999999" }
					hl.GitGraphBranchMsg = { fg = "#c1c1c1" }
					hl.GitGraphBranch1 = { fg = "#c4746e" }
					hl.GitGraphBranch2 = { fg = "#7799bb" }
					hl.GitGraphBranch3 = { fg = "#7AA89F" }
					hl.GitGraphBranch4 = { fg = "#d4b878" }
					hl.GitGraphBranch5 = { fg = "#999999" }
					hl.FFFBorder = { fg = "#50585d" }
					hl.BlinkCmpLabelMatch = { fg = "#7AA89F" }

					-- FFF stuff
					hl.CustomFFFGitStaged = { fg = "#c4746e" }
					hl.CustomFFFGitModified = { fg = "#7AA89F" }
					hl.CustomFFFGitDeleted = { fg = "#d4b878" }
					hl.CustomFFFGitRenamed = { fg = "#7799bb" }
					hl.CustomFFFGitUntracked = { fg = "#999999" }
					hl.CustomFFFGitIgnored = { fg = "#999999" }
					hl.CustomFFFGitSignStaged = { fg = "#c4746e" }
					hl.CustomFFFGitSignModified = { fg = "#7AA89F" }
					hl.CustomFFFGitSignDeleted = { fg = "#d4b878" }
					hl.CustomFFFGitSignRenamed = { fg = "#7799bb" }
					hl.CustomFFFGitSignUntracked = { fg = "#999999" }
					hl.CustomFFFGitSignIgnored = { fg = "#999999" }
					hl.CustomFFFGitSignStagedSelected = { fg = "#c4746e" }
					hl.CustomFFFGitSignModifiedSelected = { fg = "#7AA89F" }
					hl.CustomFFFGitSignDeletedSelected = { fg = "#d4b878" }
					hl.CustomFFFGitSignRenamedSelected = { fg = "#7799bb" }
					hl.CustomFFFGitSignUntrackedSelected = { fg = "#999999" }
					hl.CustomFFFGitSignIgnoredSelected = { fg = "#999999" }
				end,
			})
		end,
	},
	-- NOTE: monochrome
	{
		"idr4n/github-monochrome.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			transparent = true,
			styles = {
				comments = { italic = false },
				keywords = { italic = false },
				floats = "transparent",
			},
			on_colors = function(c, s)
				c.terminal.green = "#0350AE"
				c.terminal.green_bright = "#0350AE"
				if s == "light" then
					c.fg = "#000000"
					c.string = "#0350AE"
					c.green = "#0350AE"
					c.comment = "#979697"
				end
			end,
			on_highlights = function(hl, c)
				-- Main backgrounds
				hl.Normal = { bg = c.none }
				hl.NormalNC = { bg = c.none }
				hl.Visual = { bg = "#B2B2B3" }
				hl.NormalFloat = { bg = c.none }
				hl.FloatBorder = { bg = c.none }
				hl.FloatTitle = { bg = c.none }

				hl.SnacksDashboardHeader = { fg = c.fg, bold = true }
				-- Noice LSP progress notifications (bottom right)
				hl.NoiceLspProgressTitle = { fg = c.blue } -- Change title color
				hl.NoiceLspProgressClient = { fg = c.fg } -- Client name color
				hl.NoiceLspProgressSpinner = { fg = c.blue } -- Spinner color
				hl.NoiceCmdlinePopupBorder = { fg = "#9E3B3B" }
				hl.NoiceCmdlinePopup = { bg = c.none }
				hl.NoiceCmdlineIcon = { fg = "#9E3B3B" }

				-- Indent guides
				hl.IblIndent = { fg = "#CBCBCB", bold = true } -- Light grey for all indent lines
				hl.IblScope = { fg = "#000000" } -- Black for current scope
				hl.MiniIndentscopeSymbol = { fg = "#000000" } -- active scope (was IblScope)
				hl.MiniIndentscopeSymbolOff = { fg = "#CBCBCB" } -- inactive indent (was IblIndent)

				-- Telescope
				hl.TelescopeNormal = { bg = c.none }
				hl.TelescopeBorder = { bg = c.none }
				hl.TelescopeTitle = { bg = c.none }
				hl.TelescopePromptNormal = { bg = c.none }
				hl.TelescopePromptBorder = { bg = c.none }
				hl.TelescopePromptTitle = { bg = c.none }
				hl.TelescopePromptPrefix = { bg = c.none }
				hl.TelescopeResultsNormal = { bg = c.none }
				hl.TelescopeResultsBorder = { bg = c.none }
				hl.TelescopeResultsTitle = { bg = c.none }
				hl.TelescopePreviewNormal = { bg = c.none }
				hl.TelescopePreviewBorder = { bg = c.none }
				hl.TelescopePreviewTitle = { bg = c.none }

				-- Snacks Picker
				hl.SnacksPickerInputBorder = { fg = c.black, bg = c.bg_float }
				hl.SnacksPickerListCursorLine = { bg = "#B2B2B3" }
				hl.SnacksPickerPreviewCursorLine = { bg = "#B2B2B3" }
				hl.SnacksPickerPreviewTitle = { fg = "#D73A49", bg = c.bg_float }
				hl.SnacksPickerInputTitle = { fg = "#D73A49", bg = c.bg_float }
				hl.SnacksPickerMatch = { fg = "#D73A49", bold = true } -- Change to red

				-- LSP/Completion menu (nvim-cmp)
				hl.Pmenu = { bg = c.none }
				hl.PmenuSel = { bg = c.none }
				hl.PmenuSbar = { bg = c.none }
				hl.PmenuThumb = { bg = c.none }
				hl.CmpItemAbbr = { bg = c.none }
				hl.CmpItemAbbrMatch = { bg = c.none }
				hl.CmpItemAbbrMatchFuzzy = { bg = c.none }
				hl.CmpItemKind = { bg = c.none }
				hl.CmpItemMenu = { bg = c.none }

				-- Sidebars and special windows
				hl.NvimTreeNormal = { bg = c.none }
				hl.NeoTreeNormal = { bg = c.none }
				hl.LazyNormal = { bg = c.none }
				hl.MasonNormal = { bg = c.none }

				-- Status and tab lines
				hl.StatusLine = { bg = c.none }
				hl.StatusLineNC = { bg = c.none }
				hl.TabLine = { bg = c.none }
				hl.TabLineFill = { bg = c.none }

				-- Line numbers and signs
				hl.SignColumn = { bg = c.none }
				hl.LineNr = { bg = c.none }
				hl.CursorLineNr = { bg = c.none }

				-- Git signs
				hl.GitSignsAdd = { bg = c.none }
				hl.GitSignsChange = { bg = c.none }
				hl.GitSignsDelete = { bg = c.none }
			end,
		},
	},
	--NOTE: E-Ink
	{
		"e-ink-colorscheme/e-ink.nvim",
		-- name = "ink",
		priority = 1000,
		config = function()
			require("e-ink").setup()
			vim.opt.background = "light"
			local set_hl = vim.api.nvim_set_hl
			local mono = require("e-ink.palette").mono()
			set_hl(0, "Normal", { fg = mono[12], bg = "NONE" })
		end,
	},
	--NOTE Vague
	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			require("vague").setup({
				transparent = true,
				bold = true,
				italic = false,
				colors = {
					func = "#BC96B0",
					keyword = "#787BAB",
					string = "#D4BD98",
					-- string = "#8A739A",
					-- string = "#F2E6FF",
					-- number = "#F2E6FF",
					-- string = D8D5B1",
					number = "#8F729E",
					-- type = "#DCAED7",
				},
				on_highlights = function(hl, c)
					-- indent guides
					hl.MiniIndentscopeSymbol = { fg = "#787BAB" } -- active scope (was IblScope)
					hl.MiniIndentscopeSymbolOff = { fg = "#2A2A35" } -- inactive indent (was IblIndent)
					hl.IblIndent = { fg = "#2A2A35" }
					hl.IblWhitespace = { fg = "#CDCDCD" }
					hl.IblScope = { fg = "#787BAB" }
					hl.SnacksDashboardHeader = { fg = "#787BAB", bold = true }
					hl.FloatBorder = { fg = "#D4BD98" }
					-- hl.LineNr = { fg = "#2A2A35" } -- inactive line numbers (dim)
					-- hl.LineNrAbove = { fg = "#2A2A35" } -- relative numbers above
					-- hl.LineNrBelow = { fg = "#2A2A35" } -- relative numbers below
					-- hl.CursorLineNr = { fg = "#CDCDCD" } -- current line number
				end,
			})
		end,
	},
	--NOTE Fogbell
	{
		"jaredgorski/fogbell.vim",
	},
	--NOTE Lackluster
	{
		"slugbyte/lackluster.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("lackluster").setup({
				tweak_background = {
					-- normal = "default", -- main background
					normal = "none", -- transparent
					-- normal = '#a1b2c3',    -- hexcode
					-- normal = color.green,    -- lackluster color
					telescope = "none", -- telescope
					menu = "none", -- nvim_cmp, wildmenu ... (bad idea to transparent)
					popup = "none", -- lazy, mason, whichkey ... (bad idea to transparent)
				},
			})
		end,
	},
	-- NOTE: Catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true, -- disables setting the background color.
				float = {
					transparent = true, -- enable transparent floating windows
					solid = true, -- use solid styling for floating windows, see |winborder|
				},
				show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
				term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				no_underline = false, -- Force no underline
				styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
					comments = { "italic" }, -- Change the style of comments
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
					-- miscs = {}, -- Uncomment to turn off hard-coded styles
				},
				color_overrides = {
					mocha = (function()
						-- hex -> r,g,b (0-1)
						local function hex_to_rgb(hex)
							hex = hex:gsub("#", "")
							return tonumber(hex:sub(1, 2), 16) / 255,
								tonumber(hex:sub(3, 4), 16) / 255,
								tonumber(hex:sub(5, 6), 16) / 255
						end

						-- r,g,b -> h,s,l
						local function rgb_to_hsl(r, g, b)
							local max, min = math.max(r, g, b), math.min(r, g, b)
							local l = (max + min) / 2
							if max == min then
								return 0, 0, l
							end
							local d = max - min
							local s = l > 0.5 and d / (2 - max - min) or d / (max + min)
							local h
							if max == r then
								h = (g - b) / d + (g < b and 6 or 0)
							elseif max == g then
								h = (b - r) / d + 2
							else
								h = (r - g) / d + 4
							end
							return h / 6, s, l
						end

						-- h,s,l -> hex
						local function hsl_to_hex(h, s, l)
							local function hue(p, q, t)
								if t < 0 then
									t = t + 1
								end
								if t > 1 then
									t = t - 1
								end
								if t < 1 / 6 then
									return p + (q - p) * 6 * t
								end
								if t < 1 / 2 then
									return q
								end
								if t < 2 / 3 then
									return p + (q - p) * (2 / 3 - t) * 6
								end
								return p
							end
							local r, g, b
							if s == 0 then
								r, g, b = l, l, l
							else
								local q = l < 0.5 and l * (1 + s) or l + s - l * s
								local p = 2 * l - q
								r = hue(p, q, h + 1 / 3)
								g = hue(p, q, h)
								b = hue(p, q, h - 1 / 3)
							end
							return string.format(
								"#%02x%02x%02x",
								math.floor(r * 255 + 0.5),
								math.floor(g * 255 + 0.5),
								math.floor(b * 255 + 0.5)
							)
						end

						-- reduce saturation by factor (0 = grayscale, 1 = original)
						local function mute(hex, factor)
							factor = factor or 0.5
							local r, g, b = hex_to_rgb(hex)
							local h, s, l = rgb_to_hsl(r, g, b)
							return hsl_to_hex(h, s * factor, l)
						end

						local p = require("catppuccin.palettes").get_palette("mocha")
						local result = {}
						for name, hex in pairs(p) do
							result[name] = mute(hex)
						end
						return result
					end)(),
				},
				custom_highlights = {
					-- Visual = { bg = "#5f5faf", fg = "#C5F6FA", blend = 30 },
				},
				default_integrations = true,
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					treesitter = true,
					notify = true,
					flash = true,
					gitgraph = true,
					diffview = true,
					fidget = true,
					markview = true,
					mason = true,
					noice = true,
					octo = true,
					overseer = true,
					render_markdown = true,
					dadbod_ui = true,
					snacks = {
						enabled = true,
						indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: overlay2
					},
					mini = {
						enabled = true,
						indentscope_color = "blue",
					},
					indent_blankline = {
						enabled = true,
						scope_color = "blue", -- catppuccin color (eg. `lavender`) Default: text
						colored_indent_levels = false,
					},
					blink_cmp = {
						style = "bordered",
					},
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})
		end,
	},
	-- NOTE: Rose pine
	{
		"rose-pine/neovim",
		name = "rose-pine",
		-- priority = 1000,
		config = function()
			require("rose-pine").setup({
				variant = "main", -- auto, main, moon, or dawn
				dark_variant = "main", -- main, moon, or dawn
				dim_inactive_windows = false,
				-- disable_background = true,
				-- 	disable_nc_background = false,
				-- 	disable_float_background = false,
				-- extend_background_behind_borders = false,
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
				highlight_groups = {
					ColorColumn = { bg = "#1C1C21" },
					Normal = { bg = "none" }, -- Main background remains transparent
					Pmenu = { bg = "", fg = "#e0def4" }, -- Completion menu background
					PmenuSel = { bg = "#4a465d", fg = "#f8f5f2" }, -- Highlighted completion item
					PmenuSbar = { bg = "#191724" }, -- Scrollbar background
					PmenuThumb = { bg = "#9ccfd8" }, -- Scrollbar thumb
				},
				enable = {
					terminal = false,
					legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
					migrations = true, -- Handle deprecated options automatically
				},
			})

			-- HACK: set this on the color you want to be persistent
			-- when quit and reopening nvim
			-- vim.cmd("colorscheme rose-pine")
		end,
	},
	-- NOTE: gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		-- priority = 1000 ,
		config = function()
			require("gruvbox").setup({
				terminal_colors = false, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					folds = false,
					operators = false,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {
					Pmenu = { bg = "" }, -- Completion menu background
				},
				dim_inactive = false,
				transparent_mode = true,
			})
		end,
	},
	-- NOTE: Kanagawa

	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = false,
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = false },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true,
				dimInactive = false,
				terminalColors = true,
				colors = {
					palette = {
						fujiWhite = "#DCD7BA",
						oldWhite = "#C8C093",
						waveBlue1 = "#223249",
						waveBlue2 = "#2D4F67",
						winterGreen = "#2B3328",
						winterYellow = "#49443C",
						winterRed = "#43242B",
						winterBlue = "#252535",
						autumnGreen = "#76946A",
						autumnRed = "#C34043",
						autumnYellow = "#DCA561",
						samuraiRed = "#E82424",
						roninYellow = "#FF9E3B",
						waveAqua1 = "#6A9589",
						dragonBlue = "#658594",
						fujiGray = "#727169",
						springViolet1 = "#938AA9",
						oniViolet = "#957FB8",
						crystalBlue = "#7E9CD8",
						springViolet2 = "#9CABCA",
						springBlue = "#7FB4CA",
						lightBlue = "#A3D4D5",
						waveAqua2 = "#7AA89F",
						springGreen = "#98BB6C",
						boatYellow1 = "#938056",
						boatYellow2 = "#C0A36E",
						carpYellow = "#E6C384",
						sakuraPink = "#D27E99",
						waveRed = "#E46876",
						peachRed = "#FF5D62",
						surimiOrange = "#FFA066",
						katanaGray = "#717C7C",
					},
					overrides = function(colors)
						local theme = colors.theme
						return {}
					end,
					theme = {
						-- applies to all variants (wave/dragon/lotus)
						all = {
							ui = {
								-- bg = "none",
								bg_gutter = "none",
								bg_dim = "none",
								bg_m1 = "none",
								bg_m2 = "none",
								-- bg_m3 = "none",
								bg_p1 = "none",
								bg_p2 = "none",
								-- bg_visual = "#333738",
								-- bg_search = "none",
								float = { bg = "none", bg_border = "none" },
								sidebar = { bg = "none", bg_border = "none" },
								popup = { bg = "none", bg_border = "none" },
							},
						},
					},
				},
				theme = "dragon",
				background = {
					dark = "dragon",
					light = "lotus",
				},
			})
		end,
	},
	{
		"thesimonho/kanagawa-paper.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
		config = function()
			require("kanagawa-paper").setup({
				transparent = true,
			})
		end,
	},
	-- NOTE: neosolarized
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
				terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
				styles = {
					-- Style to be applied to different syntax groups
					-- Value is any valid attr-list value for `:help nvim_set_hl`
					comments = { italic = true },
					keywords = { italic = false },
					functions = {},
					variables = {},
					-- Background styles. Can be "dark", "transparent" or "normal"
					sidebars = "dark", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
				day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = c.bg_dark,
					}
					hl.TelescopePromptBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = "#2C94DD",
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
		end,
	},
	-- NOTE : tokyonight
	{
		"folke/tokyonight.nvim",
		name = "folkeTokyonight",
		-- priority = 1000,
		config = function()
			local transparent = true
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local fg_gutter = "#627E97"
			local border = "#547998"

			require("tokyonight").setup({
				style = "night",
				transparent = transparent,

				styles = {
					comments = { italic = false },
					keywords = { italic = false },
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = transparent and colors.none or bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
		end,
	},
}
