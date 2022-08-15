local ls = require("luasnip")
local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

ls.add_snippets("all", {
    s({
        trig = "#!",
        namr = "Shebang",
        dscr = "Inputs the shebang line",
    }, {
        t"#!/bin/",
        c(1, {
            t"bash",
            t"dash",
            t"python",
        }),
        i(0)
    }),
})
