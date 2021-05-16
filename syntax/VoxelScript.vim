if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "VoxelScript"

" Redraw the syntax highlighting from the start
syntax sync fromstart

" @= for positive look-ahead, @<= for positive look-behind, @! for negative look-ahead
" (?!X) => (X)@!
" \b => (<|>)       # < or start of word, > for end of word

let __CONTROL_FLOW = '%(return|import|if|else|for|while|export)%(\w)@!'
let __KEYWORDS = '%(true|false|void|any|this|int|char|double|bool|string|import|const|trait|init|class|return|implement|private|on|new|is|not|if|else|for|while|throw|export|typedef|\=\>)%(\w)@!'
let __IDENTIFIER = '%(%(%(<|>)[a-zA-Z_][a-zA-Z_0-9]*)%(\w)@!)'
let __NONCAPTURE_IDENTIFIER = '%(%(<|>)[a-zA-Z_][a-zA-Z_0-9]*)%(\w)@!'
let __NONCAPTURE_TYPE = '%(' . __NONCAPTURE_IDENTIFIER . '%(\s*\<[\s\w\<\>\[\]\\,]+\>)?%(\s[\[\]])*' . ')'

syntax match context_comments_2 "\v\/\/.*"
syntax region context_comments_1 start="\v\/\*" end="\*\/"

syntax region string_stuff matchgroup=string_stuff_0 start="\v\"" end="\v\"" transparent contains=string_stuff_1
syntax match string_stuff_1 "\v[^"]" keepend contained

let pattern_11_str = 'syntax match pattern_11 "\v' . __IDENTIFIER . '"'
exec pattern_11_str


let pattern_13_str = 'syntax match pattern_13 "\v' . __IDENTIFIER . '\s*(' . __IDENTIFIER . '\s*[\(])@="'
exec pattern_13_str
highlight link pattern_13 VSType

let pattern_12_str = 'syntax match pattern_12 "\v' . __IDENTIFIER . '(\s*[\(])@="'
exec pattern_12_str
highlight link pattern_12 VSFunc

let pattern_10_str = 'syntax match pattern_10 "\v' . __KEYWORDS . '"'
exec pattern_10_str

" // Color "CUSTOM_TYPE VARIABLE" accordingly
" pattern_9
let pattern_9_str = 'syntax region pattern_9 start="\v' . __NONCAPTURE_TYPE . '(\s*)' . __IDENTIFIER . '(\s*\=)@=" end="=" transparent contains=pattern_9_0,pattern_9_1_1,pattern_9_1_2'
exec pattern_9_str
exec 'syntax match pattern_9_1_2 "\v\s*' . __NONCAPTURE_TYPE . '" contained'
exec 'syntax match pattern_9_1_1 "\v\s*' . __KEYWORDS . '" contained'
exec 'syntax match pattern_9_0 "\v\s*' . __IDENTIFIER . '(\s*\=)@=" contained'

" // Color all "is (not)? TYPE;"
" pattern_8

" // Color all "new CUSTOM_TYPE"
" pattern_7

" // Color end of "typedef NEW_CUSTOM_TYPE = args (=> CUSTOM_TYPE);", along with the custom return type of lambdas (=> CUSTOM_TYPE)
" pattern_6

" // Color beginning of "(typedef NEW_CUSTOM_TYPE) = args => CUSTOM_TYPE;"
" syntax match pattern_5 "\v((<|>)typedef\s+)(<[a-zA-Z_][a-zA-Z_0-9]*)(\w)@!" contains=pattern_5_1,pattern_5_2
" syntax match pattern_5_2 "\v((<|>)typedef\s+)@<=(<[a-zA-Z_][a-zA-Z_0-9]*)(\w)@!" contained
" syntax match pattern_5_1 "\v((<|>)typedef\s+)((<[a-zA-Z_][a-zA-Z_0-9]*)(\w)@!)@=" nextgroup=pattern_5_2 contained

" // Color all "typedef NEW_CUSTOM_TYPE = CUSTOM_TYPE;"
let pattern_4_str = 'syntax region pattern_4 start="\v((<|>)typedef\s+)' . __IDENTIFIER . '(\s*\=)(\s*' . __NONCAPTURE_TYPE . '\s*)" end="\v(\s*;)@=" transparent contains=pattern_4_0_1,pattern_4_0_2,pattern_4_0_3,pattern_4_1_1,pattern_4_1_2,pattern_411'
exec pattern_4_str
exec 'syntax match pattern_4_1_2 "\v\s*' . __NONCAPTURE_TYPE . '" contained'
exec 'syntax match pattern_4_1_1 "\v\s*' . __KEYWORDS . '" contained'
syntax match pattern_4_0_3 '\v(\s*\=)' contained
exec 'syntax match pattern_4_0_2 "\v' . __IDENTIFIER . '" contained nextgroup=pattern_4_0_3'
syntax match pattern_4_0_1 "\v((<|>)typedef\s+)" contained nextgroup=pattern_4_0_2

syntax region pattern_3 start="\v(implement|class|trait)@=" end="\v\{" transparent contains=pattern_3_1,pattern_3_2,pattern_3_3,pattern_3_4_1,pattern_3_4_2,pattern_3_5
syntax match pattern_3_5 "\v[^\{]" contained keepend
syntax match pattern_3_4_2 "\v\/\/.*" contained keepend
syntax region pattern_3_4_1 start="\v\/\*" end="\*\/" contained extend
syntax match pattern_3_3 "\v((<|>)[a-zA-Z_][a-zA-Z_0-9]*)(\w)@!" contained
exec 'syntax match pattern_3_2 "\v' . __KEYWORDS . '" contained'
syntax match pattern_3_1 "\v::" contained

syntax match pattern_2 "\v((<|>)_(<|>))"

exec 'syntax match pattern_1 "\v(\s*)' . __CONTROL_FLOW . '"'

highlight link pattern_1 VSSpecial
highlight link pattern_2 White
highlight link pattern_3_1 White
highlight link pattern_3_2 VSKeyword
highlight link pattern_3_3 VSType
highlight link pattern_3_4_1 VSComment
highlight link pattern_3_4_2 VSComment
highlight link pattern_3_5 White
highlight link pattern_4_0_1 VSKeyword
highlight link pattern_4_0_2 VSType
highlight link pattern_4_0_3 White
highlight link pattern_4_1_1 VSKeyword
highlight link pattern_4_1_2 VSType
highlight link pattern_5_1 VSKeyword
highlight link pattern_5_2 VSType
highlight link pattern_9_0 VSVariable
highlight link pattern_9_1_1 VSKeyword
highlight link pattern_9_1_2 VSType
highlight link pattern_10 VSKeyword
highlight link pattern_11 VSVariable
highlight link string_stuff_0 VSString
highlight link string_stuff_1 VSString
highlight link context_comments_2 VSComment
highlight link context_comments_1 VSComment

highlight VSComment ctermfg=65 guifg=#6A9955
highlight VSSpecial ctermfg=176 guifg=#C586C5
highlight VSKeyword ctermfg=74 guifg=#569CD6
highlight VSType ctermfg=79 guifg=#4EC9B0
highlight VSVariable ctermfg=153 guifg=#9CDCFE
highlight VSString ctermfg=174 guifg=#CE9178
highlight VSFunc ctermfg=187 guifg=#DCDCAA
