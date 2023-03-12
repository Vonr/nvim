local ls = require("luasnip")
local s = ls.snippet
local n = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local basic = function(trigger, expanded, autosnippet)
    return s({
        trig = '\\' .. trigger,
        snippetType = (not not autosnippet) and 'autosnippet' or 'snippet'
    }, {
        t('\\' .. expanded .. '{'),
        i(1),
        t('}'),
        i(0),
    })
end

ls.add_snippets('tex', {
    basic('dc', 'document', true),
    basic('dC', 'documentClass', true),
    basic('ss', 'section', true),
    basic('2r', 'sqrt', true),
    s({
        trig = '\\fr',
        snippetType = 'autosnippet',
    }, {
        t('\\frac{'),
        i(1),
        t('}{'),
        i(2),
        t('}'),
        i(0),
    }),
    s({
        trig = '\\nr',
        snippetType = 'autosnippet',
    }, {
        t('\\sqrt['),
        i(1),
        t(']{'),
        i(2),
        t('}'),
        i(0),
    })
})
