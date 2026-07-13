return {
	{
		"saghen/blink.cmp",
		version = "v1.*",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			-- Load vscode-style snippets
			require("luasnip.loaders.from_vscode").lazy_load()

			-- Load your custom snippets
			local has_luasnip, luasnip = pcall(require, "luasnip")
			if has_luasnip then
				luasnip.add_snippets("c", require("snippets.c"))
				luasnip.add_snippets("lua", require("snippets.lua"))
				luasnip.add_snippets("cpp", require("snippets.cpp"))
				luasnip.add_snippets("cpp", require("snippets.c"))
				luasnip.add_snippets("python", require("snippets.python"))
			end
			require("blink.cmp").setup({
				fuzzy = {
					implementation = "prefer_rust",
				},
				keymap = {
					preset = "none", -- disable defaults so your mappings are the only ones
					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },
					["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide", "fallback" },
					["<CR>"] = { "accept", "fallback" }, -- select = false is the default (won't accept on CR unless item is selected)
				},
				completion = {
					menu = {
						draw = {
							columns = {
								{ "kind_icon" },
								{ "label", "label_description", gap = 1 },
								{ "kind", gap = 1 },
								{ "label_description", gap = 1 },
								{ "source_name", gap = 1 },
							},
							components = {
								kind_icon = {
									ellipsis = false,
									width = { fill = true },
									text = function(ctx)
										local kind_icons = {
											Function = "λ",
											Method = "∂",
											Field = "󰀫",
											Variable = "󰀫",
											Property = "󰀫",
											Keyword = "k",
											Struct = "Π",
											Enum = "τ",
											EnumMember = "τ",
											Snippet = "⊂",
											Text = "τ",
											Module = "⌠",
											Constructor = "∑",
											Class = " ",
											Color = " ",
											Constant = "󰏿",
											File = " ",
											Folder = " ",
											Interface = " ",
											Operator = " ",
											Reference = " ",
											TypeParameter = " ",
											Unit = " ",
											Value = " ",
											Array = "󰅪",
											Event = "",
										}
										local icon = kind_icons[ctx.kind]
										if icon == nil then
											icon = ctx.kind_icon
										end
										return icon
									end,
								},
							},
						},
						-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
						scrollbar = false,
						auto_show = true,
					},
					documentation = {
						auto_show = true,
						auto_show_delay_ms = 0, -- adjust delay to taste
						window = {
							-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
							winblend = 100,
							scrollbar = false,
						},
					},
					ghost_text = {
						enabled = true,
						show_with_menu = true,
					},
					accept = {
						auto_brackets = {
							enabled = true,
						},
					},
				},
				cmdline = {
					enabled = true,
					keymap = { preset = "cmdline" },
					completion = {
						menu = { auto_show = true },
					},
				},
				sources = {
					default = { "snippets", "lsp", "path", "buffer" },
					providers = {
						lsp = {
							opts = {
								tailwind_color_icon = "󱓻",
							},
						},
					},
				},
				appearance = {
					use_nvim_cmp_as_default = false,
					nerd_font_variant = "mono",
				},
				signature = {
					enabled = true,
					window = {
						show_documentation = false,
					},
				},
				snippets = {
					preset = "luasnip",
				},
			})
		end,
	},
}
