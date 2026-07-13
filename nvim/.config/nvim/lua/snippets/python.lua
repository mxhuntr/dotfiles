-- ~/.config/nvim/lua/snippets/python.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
	-- main guard
	s("main", {
		t("def main():"),
		t({ "", "    " }),
		i(1, "pass"),
		t({ "", "", "", 'if __name__ == "__main__":' }),
		t({ "", "    main()" }),
	}),

	s("ig", {
		t("# type: ignore"),
	}),

	-- function
	s("dr", {
		t("def "),
		i(1, "func_name"),
		t("("),
		i(2),
		t("):"),
		t({ "", "    " }),
		i(3, "return"),
	}),

	-- class
	s("cls", {
		t("class "),
		i(1, "ClassName"),
		t(":"),
		t({ "", "    def __init__(self, " }),
		i(2),
		t("):"),
		t({ "", "        " }),
		i(3, "pass"),
	}),

	-- print
	s("pp", {
		t("print("),
		i(1),
		t(")"),
	}),

	-- print f-string
	s("pf", {
		t('print(f"'),
		i(1),
		t('")'),
	}),

	-- with open
	s("wop", {
		t('with open("'),
		i(1, "file"),
		t('", "'),
		i(2, "r"),
		t('") as '),
		i(3, "f"),
		t(":"),
		t({ "", "    " }),
		i(4, "pass"),
	}),
}
