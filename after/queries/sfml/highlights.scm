[ (HAS) (LONE) (MOVE) (SIDE) (REDSTONE) (WORLD) (PROGRAM) (LPAREN) (RPAREN) ] @keyword
(trigger [ (EVERY) (DO) (END) ] @keyword.repeat)
(EACH) @keyword.repeat
[ (INPUT) (OUTPUT) (FORGET) ] @function.builtin
[ (IF) (THEN) (ELSE) (WHERE) ] @keyword.conditional
(ifstatement (END) @keyword.conditional)
[ (OVERALL) (SOME) (ONE) (LONE) (GT) (GT_SYMBOL) (LT) (LT_SYMBOL) (EQ) (EQ_SYMBOL) (LE) (LE_SYMBOL) (GE) (GE_SYMBOL) (NOT) (AND) (OR) (FROM) (TO) (SLOTS) (RETAIN) (EXCEPT) (roundrobin) ] @keyword.operator

(number) @number
(string) @string
[ (TRUE) (FALSE) ] @boolean
(label) @label
(name) @module
(LINE_COMMENT) @comment
(resourceid) @type
[ (LABEL) (BLOCK) ] @type.builtin
[ (COMMA) (COLON) (DASH) ] @punctuation.delimiter
[ (TOP) (BOTTOM) (NORTH) (EAST) (SOUTH) (WEST) ] @constant.builtin
(resourceid (REDSTONE)) @type (#set! priority 105)

(trigger (interval [ (TICK) (TICKS) (SECONDS) ] @type.builtin (#set! priority 105)))
(trigger interval: (redstonepulse) @type.builtin (#set! priority 105))

