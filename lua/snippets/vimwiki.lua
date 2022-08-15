local ls = require("luasnip")
local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets(nil, {
    vimwiki = {
        s({
            trig = "h",
            namr = "Header",
            dscr = "Creates a header"
        }, {
            c(1, {
                t"=",
                t"==",
                t"===",
                t"====",
                t"=====",
                t"======",
            }),
            t" ",
            i(2),
            t" ",
            d(3, function(args)
                return n(nil, {
                    i(1, args[1])
                })
            end,
            {1}),
            i(0)
        }),
        s({
            trig = "x",
            namr = "Checkbox",
            dscr = "Creates a checkbox"
        }, {
            c(1, {
                t"*",
                t"-",
            }),
            t" [ ",
            i(0),
            t"]",
            t" ",
            i(2),
        }),
        s({
            trig = "b",
            namr = "Block",
            dscr = "Creates a block"
        }, {
            t"{{{",
            c(1, {
                t"rust",
                t"go",
                t"python",
                t"java",
                t"lua",
                t"md",
            }),
            t{"", ""},
            i(0),
            t{"", "}}}"},
        }),
    }
})
