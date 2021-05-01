au BufNewFile,BufRead *.pn set filetype=potion

if exists("b:current_syntax")
    finish
endif

echom "Our syntax highlighting code will go here."

let b:current_syntax = "potion"

syntax keyword potionKeyword to times
highlight link potionKeyword Keyword
