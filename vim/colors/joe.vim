" Vim color file
" vim: tw=0 ts=8 sw=4
" Scriptname:   joe
" Maintainer:   Joe Legner
" Version:      0.2
" Last Change:  20120118
" As of now only gui is supported
" Based on the theme buttercream

set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let colors_name = "joe"

"Boolean         links to Constant

"Character       links to Constant

"ColorColumn	 used for the columns set with 'colorcolumn'
hi ColorColumn   term=reverse ctermbg=LightGrey guibg=LightGrey

" Comment
hi Comment       term=bold ctermfg=1 guifg=DarkGreen

"Conceal	 placeholder characters substituted for concealed text (see 'conceallevel')
hi Conceal       ctermfg=7 ctermbg=8 guifg=LightGrey guibg=DarkGrey

"Conditional     links to Statement

"Constant - used for numbers in Python
hi Constant     term=underline ctermfg=4 guifg=Blue

"Cursor		the character under the cursor
hi Cursor       guifg=bg guibg=fg

"CursorColumn	the screen column that the cursor is in when 'cursorcolumn' is set
hi CursorColumn term=reverse ctermbg=7 guibg=Grey90

"CursorIM	like Cursor, but used when in IME mode |CursorIM|

"CursorLine	the screen line that the cursor is in when 'cursorline' is set
hi CursorLine   term=underline cterm=underline guibg=Grey80

"Debug           links to Special

"Define          links to PreProc

"Delimiter       links to Special

"DiffAdd	diff mode: Added line |diff.txt|
hi DiffAdd      term=bold ctermbg=9 guibg=LightBlue

"DiffChange	diff mode: Changed line |diff.txt|
hi DiffChange   term=bold ctermbg=13 guibg=LightMagenta

"DiffDelete	diff mode: Deleted line |diff.txt|
hi DiffDelete   term=bold ctermfg=9 ctermbg=11 gui=bold guifg=Blue guibg=LightCyan

"DiffText	diff mode: Changed text within a changed line |diff.txt|
hi DiffText     term=reverse cterm=bold ctermbg=12 gui=bold guibg=Red

"Directory	directory names (and other special names in listings)
hi Directory    term=bold ctermfg=1 guifg=Blue

hi Error        term=reverse ctermfg=15 ctermbg=12 guifg=White guibg=Red

"ErrorMsg	error messages on the command line
hi ErrorMsg     term=standout ctermfg=15 ctermbg=4 guifg=White guibg=Red

"Exception       links to Statement

"Float           links to Number

"FoldColumn	'foldcolumn'
hi FoldColumn   term=standout ctermfg=1 ctermbg=7 guifg=DarkBlue guibg=Grey

"Folded		line used for closed folds
hi Folded       term=standout ctermfg=1 ctermbg=7 guifg=DarkBlue guibg=LightGrey

"Function        links to Identifier

"Identifier - Python: function names, True, False, None
hi Identifier   term=underline ctermfg=3 guifg=#a60000

hi Ignore       ctermfg=15 guifg=bg

"IncSearch	'incsearch' highlighting; also used for the text replaced with ":s///c"
hi IncSearch    term=reverse cterm=reverse gui=reverse

"Include         links to PreProc

"Keyword         links to Statement

"Label           links to Statement

"LineNr		Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
hi LineNr       term=underline ctermfg=6 guifg=Brown

"Macro           links to PreProc

"MatchParen	The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
hi MatchParen   term=reverse ctermbg=11 guibg=Cyan

"ModeMsg		'showmode' message (e.g., "-- INSERT --")
hi ModeMsg      term=bold cterm=bold gui=bold

"MoreMsg		|more-prompt|
hi MoreMsg      term=bold ctermfg=2 gui=bold guifg=SeaGreen

"NonText		'~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
hi NonText      term=bold ctermfg=9 gui=bold guifg=Blue

" NORMAL TEXT
hi Normal       font=Lucida_Console:h11:cDEFAULT

"Number          links to Constant

"Operator        links to Statement

"Pmenu		Popup menu: normal item.
hi Pmenu        ctermbg=13 guibg=LightMagenta

"PmenuSbar	Popup menu: scrollbar.
hi PmenuSbar    ctermbg=7 guibg=Grey

"PmenuSel	Popup menu: selected item.
hi PmenuSel     ctermbg=7 guibg=Grey

"PmenuThumb	Popup menu: Thumb of the scrollbar.
hi PmenuThumb   cterm=reverse gui=reverse

"PreCondit       links to PreProc

"PreProc        Pre-processor directive - Python: from, import
hi PreProc      term=underline ctermfg=5 guifg=DarkGrey

"Question	|hit-enter| prompt and yes/no questions
hi Question     term=standout ctermfg=2 gui=bold guifg=SeaGreen

"Repeat          links to Statement

"Search		Last search pattern highlighting (see 'hlsearch').  Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
hi Search       term=reverse ctermfg=0 ctermbg=14 guibg=Yellow

"SignColumn	column where |signs| are displayed
hi SignColumn   term=standout ctermfg=1 ctermbg=7 guifg=DarkBlue guibg=Grey

hi Special      term=bold ctermfg=5 guifg=SlateBlue

"SpecialChar     links to Special

"SpecialComment  links to Special

"SpecialKey	Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'.  Generally: text that is displayed differently from what it really is.
hi SpecialKey   term=bold ctermfg=1 guifg=Blue

"SpellBad	Word that is not recognized by the spellchecker. |spell|
hi SpellBad     term=reverse ctermbg=12 gui=undercurl guisp=Red

"SpellCap	Word that should start with a capital. |spell|
hi SpellCap     term=reverse ctermbg=9 gui=undercurl guisp=Blue

"SpellLocal	Word that is recognized by the spellchecker as one that is used in another region. |spell|
hi SpellLocal   term=underline ctermbg=11 gui=undercurl guisp=DarkCyan

"SpellRare	Word that is recognized by the spellchecker as one that is hardly ever used. |spell|
hi SpellRare    term=reverse ctermbg=13 gui=undercurl guisp=Magenta

hi Statement    term=bold ctermfg=6 gui=bold guifg=#404040

"StatusLine	status line of current window
hi StatusLine   term=bold,reverse cterm=bold,reverse gui=bold,reverse

"StatusLineNC	status lines of not-current windows
hi StatusLineNC term=reverse cterm=reverse gui=reverse

"StorageClass    links to Type

"String         
hi String       guifg=Blue

"Structure       links to Type

"TabLine	tab pages line, not active tab page label
hi TabLine      term=underline cterm=underline ctermfg=0 ctermbg=7 gui=underline guibg=LightGrey

"TabLineFill	tab pages line, where there are no labels
hi TabLineFill  term=reverse cterm=reverse gui=reverse

"TabLineSel	tab pages line, active tab page label
hi TabLineSel   term=bold cterm=bold gui=bold

"Tag             links to Special

"Title		titles for output from ":set all", ":autocmd" etc.
hi Title        term=bold ctermfg=5 gui=bold guifg=Magenta

hi Todo         term=standout ctermfg=0 ctermbg=14 guifg=Blue guibg=Yellow

hi Type         term=underline ctermfg=2 gui=bold guifg=SeaGreen

"Typedef         links to Type

hi Underlined   term=underline cterm=underline ctermfg=5 gui=underline guifg=SlateBlue

"VertSplit	the column separating vertically split windows
hi VertSplit    term=reverse cterm=reverse gui=reverse

"Visual		Visual mode selection
hi Visual       term=reverse cterm=reverse guibg=plum1

"VisualNOS	Visual mode selection when vim is "Not Owning the Selection".
hi VisualNOS    term=bold,underline cterm=bold,underline gui=bold,underline

"WarningMsg	warning messages
hi WarningMsg   term=standout ctermfg=4 guifg=Red

"WildMenu	current match in 'wildmenu' completion
hi WildMenu     term=standout ctermfg=0 ctermbg=14 guifg=Black guibg=Yellow
hi lCursor      guifg=bg guibg=fg


"==============================================================================
" Python-specific
"==============================================================================
"PyFlakes       links to SpellBad
"pythonBuiltin  links to Function
"pythonComment  links to Comment
"pythonConditional links to Conditional
"pythonDecorator links to Define
"pythonDoctest  links to Special
"pythonDoctestValue links to Define
"pythonEscape   links to Special
"pythonEtion links to Exception
"pythonEtions links to Structure
"pythonFunction links to Function
"pythonInclude  links to Include
"pythonNumber   links to Number
"pythonOperator links to Operator
"pythonPreCondit links to PreCondit
"pythonRawString links to String
"pythonRepeat   links to Repeat
"pythonSpaceError cleared
"pythonStatement links to Statement
"pythonString   links to String
"pythonSync     cleared
"pythonTodo     links to Todo


"==============================================================================
" HTML-specific
"==============================================================================
"cssAttributeSelector cleared
"cssAuralAttr   links to Type
"cssAuralProp   links to StorageClass
"cssBoxAttr     links to Type
"cssBoxProp     links to StorageClass
"cssBraceError  links to Error
"cssBraces      links to Function
"cssClassName   links to Function
"cssColor       links to Constant
"cssColorAttr   links to Type
"cssColorProp   links to StorageClass
"cssComment     links to Comment
"cssCommonAttr  links to Type
"cssDefinition  cleared
"cssError       links to Error
"cssFontAttr    links to Type
"cssFontDescriptor links to Special
"cssFontDescriptorAttr links to Type
"cssFontDescriptorBlock cleared
"cssFontDescriptorFunction links to Constant
"cssFontDescriptorProp links to StorageClass
"cssFontProp    links to StorageClass
"cssFunction    links to Constant
"cssFunctionName links to Function
"cssGeneratedContentAttr links to Type
"cssGeneratedContentProp links to StorageClass
"cssIdentifier  links to Function
"cssImportant   links to Special
"cssInclude     links to Include
"cssLength      cleared
"cssMedia       links to Special
"cssMediaBlock  cleared
"cssMediaComma  links to Normal
"cssMediaType   links to Special
"cssPagingAttr  links to Type
"cssPagingProp  links to StorageClass
"cssPseudoClass cleared
"cssPseudoClassId links to PreProc
"cssPseudoClassLang links to Constant
"cssRenderAttr  links to Type
"cssRenderProp  links to StorageClass
"cssSelectorOp  links to Special
"cssSelectorOp2 links to Special
"cssSpecialCharQ cleared
"cssSpecialCharQQ cleared
"cssString      cleared
"cssStringQ     links to String
"cssStringQQ    links to String
"cssStyle       cleared
"cssTableAttr   links to Type
"cssTableProp   links to StorageClass
"cssTagName     links to Statement
"cssTextAttr    links to Type
"cssTextProp    links to StorageClass
"cssUIAttr      links to Type
"cssUIProp      links to StorageClass
"cssURL         links to String
"cssUnicodeEscape links to Special
"cssUnicodeRange links to Constant
"cssValueAngle  links to Number
"cssValueFrequency links to Number
"cssValueInteger links to Number
"cssValueLength links to Number
"cssValueNumber links to Number
"cssValueTime   links to Number
"djangoArgument links to Constant
"djangoComBlock links to Comment
"djangoComment  links to Comment
"djangoError    links to Error
"djangoFilter   links to Identifier
"djangoStatement links to Statement
"djangoTagBlock links to PreProc
"djangoTagError links to Error
"djangoTodo     links to Todo
"djangoVarBlock links to PreProc
"djangoVarError links to Error
"htmlArg        links to Type
hi htmlBold     term=bold cterm=bold gui=bold
hi htmlBoldItalic term=bold,italic cterm=bold,italic gui=bold,italic
"htmlBoldItalicUnderline links to htmlBoldUnderlineItalic
hi htmlBoldUnderline term=bold,underline cterm=bold,underline gui=bold,underline
hi htmlBoldUnderlineItalic term=bold,underline,italic cterm=bold,underline,italic
"htmlComment    links to Comment
"htmlCommentError links to htmlError
"htmlCommentPart links to Comment
"htmlCssDefinition links to Special
"htmlCssStyleComment links to Comment
"htmlEndTag     links to Identifier
"htmlError      links to Error
"htmlEvent      links to javaScript
"htmlEventDQ    links to htmlEvent
"htmlEventSQ    links to htmlEvent
"htmlH1         links to Title
"htmlH2         links to htmlH1
"htmlH3         links to htmlH2
"htmlH4         links to htmlH3
"htmlH5         links to htmlH4
"htmlH6         links to htmlH5
"htmlHead       links to PreProc
"htmlHighlight  cleared
"htmlHighlightSkip cleared
hi htmlItalic   term=italic cterm=italic gui=italic
"htmlItalicBold links to htmlBoldItalic
"htmlItalicBoldUnderline links to htmlBoldUnderlineItalic
"htmlItalicUnderline links to htmlUnderlineItalic
"htmlItalicUnderlineBold links to htmlBoldUnderlineItalic
"htmlLink       links to Underlined
"htmlPreAttr    links to String
"htmlPreError   links to Error
"htmlPreProc    links to PreProc
"htmlPreProcAttrError links to Error
"htmlPreProcAttrName links to PreProc
"htmlPreStmt    links to PreProc
"htmlScriptTag  links to htmlTag
"htmlSpecial    links to Special
"htmlSpecialChar links to Special
"htmlSpecialTagName links to Exception
"htmlStatement  links to Statement
"htmlString     links to String
"htmlStyleArg   links to htmlString
"htmlTag        links to Function
"htmlTagError   links to htmlError
"htmlTagN       cleared
"htmlTagName    links to htmlStatement
"htmlTitle      links to Title
hi htmlUnderline  term=underline cterm=underline gui=underline
"htmlUnderlineBold links to htmlBoldUnderline
"htmlUnderlineBoldItalic links to htmlBoldUnderlineItalic
hi htmlUnderlineItalic term=underline,italic cterm=underline,italic
"htmlUnderlineItalicBold links to htmlBoldUnderlineItalic
"htmlValue      links to String
"javaScrParenError links to javaScriptError
"javaScript     links to Special
"javaScriptBoolean links to Boolean
"javaScriptBraces links to Function
"javaScriptBranch links to Conditional
"javaScriptCharacter links to Character
"javaScriptComment links to Comment
"javaScriptCommentSkip cleared
"javaScriptCommentTodo links to Todo
"javaScriptConditional links to Conditional
"javaScriptConstant links to Label
"javaScriptDebug links to Debug
"javaScriptDeprecated links to Exception
"javaScriptError links to Error
"javaScriptException links to Exception
"javaScriptExpression links to javaScript
"javaScriptFunction links to Function
"javaScriptGlobal links to Keyword
"javaScriptIdentifier links to Identifier
"javaScriptLabel links to Label
"javaScriptLineComment links to Comment
"javaScriptMember links to Keyword
"javaScriptMessage links to Keyword
"javaScriptNull links to Keyword
"javaScriptNumber links to javaScriptValue
"javaScriptOperator links to Operator
"javaScriptParens cleared
"javaScriptRegexpString links to String
"javaScriptRepeat links to Repeat
"javaScriptReserved links to Keyword
"javaScriptSpecial links to Special
"javaScriptSpecialCharacter links to javaScriptSpecial
"javaScriptStatement links to Statement
"javaScriptStringD links to String
"javaScriptStringS links to String
"javaScriptType links to Type
"javaScriptValue cleared
"vbBoolean      links to Boolean
"vbComment      links to Comment
"vbConditional  links to Conditional
"vbConst        links to Constant
"vbDefine       links to Constant
"vbError        links to Error
"vbEvents       links to Special
"vbFloat        links to Float
"vbFunction     links to Identifier
"vbIdentifier   links to Identifier
"vbKeyword      links to Statement
"vbLineNumber   links to Comment
"vbMethods      links to PreProc
"vbNumber       links to Number
"vbOperator     links to Operator
"vbRepeat       links to Repeat
"vbStatement    links to Statement
"vbString       links to String
"vbTodo         links to Todo
"vbTypeSpecifier links to Type
"vbTypes        links to Type





"==============================================================================
" rst-specific
"==============================================================================
"rstCitation    links to String
"rstCitationReference links to Identifier
"rstComment     links to Comment
"rstDelimiter   links to Delimiter
"rstDirective   links to Keyword
"rstDoctestBlock links to PreProc
"rstEmphasisDelimiter links to rstEmphasis
"rstExDirective links to String
"rstExplicitMarkup links to rstDirective
"rstFootnote    links to String
"rstFootnoteReference links to Identifier
"rstHyperlinkReference links to Identifier
"rstHyperlinkTarget links to String
"rstInlineInternalTargets links to Identifier
"rstInlineInternalTargetsDelimiter links to rstInlineInternalTargets
"rstInlineLiteral links to String
"rstInlineLiteralDelimiter links to rstInlineLiteral
"rstInterpretedText cleared
"rstInterpretedTextOrHyperlinkReference links to Identifier
"rstInterpretedTextOrHyperlinkReferenceDelimiter links to rstInterpretedTextOrHyperlinkReference
"rstLiteralBlock links to String
"rstQuotedLiteralBlock links to String
"rstSections    links to Type
"rstSimpleTable cleared
"rstSimpleTableLines links to rstTableLines
"rstStandaloneHyperlink links to Identifier
"rstStrongEmphasis links to Special
"rstStrongEmphasisDelimiter links to rstStrongEmphasis
"rstSubstitutionDefinition links to rstDirective
"rstSubstitutionReference links to PreProc
"rstSubstitutionReferenceDelimiter links to rstSubstitutionReference
"rstTable       cleared
"rstTableLines  links to rstDelimiter
"rstTodo        links to Todo
"rstTransition  links to Type
hi rstEmphasis  term=italic cterm=italic gui=italic

"==============================================================================
" LaTeX-specific
"==============================================================================
"texAbstract    cleared
"texAccent      links to texStatement
"texBadMath     links to texError
"texChapterZone cleared
"texCite        links to texRefZone
"texCmdArgs     links to Number
"texCmdBody     cleared
"texCmdName     links to Statement
"texComment     links to Comment
"texDef         links to Statement
"texDefCmd      links to texDef
"texDefName     links to texDef
"texDefParm     links to Special
"texDefParms    cleared
"texDelimiter   links to Delimiter
"texDocType     links to texCmdName
"texDocTypeArgs links to texCmdArgs
"texDocZone     cleared
"texEnvBgn      cleared
"texEnvEnd      cleared
"texEnvName     cleared
"texError       links to Error
"texGreek       links to texStatement
"texInput       links to Special
"texInputCurlies links to texDelimiter
"texInputFile   links to Special
"texInputFileOpt links to texCmdArgs
"texLength      links to Number
"texLigature    links to texSpecialChar
"texMatcher     cleared
"texMath        links to Special
"texMathDelim   links to Statement
"texMathDelimBad links to texError
"texMathDelimKey links to texMathDelim
"texMathDelimSet1 links to texMathDelim
"texMathDelimSet2 links to texMathDelim
"texMathError   links to texError
"texMathMatcher links to texMath
"texMathOper    links to Operator
"texMathSymbol  links to texStatement
"texMathText    cleared
"texMathZoneA   links to texMath
"texMathZoneAS  links to texMath
"texMathZoneB   links to texMath
"texMathZoneBS  links to texMath
"texMathZoneC   links to texMath
"texMathZoneCS  links to texMath
"texMathZoneD   links to texMath
"texMathZoneDS  links to texMath
"texMathZoneE   links to texMath
"texMathZoneES  links to texMath
"texMathZoneF   links to texMath
"texMathZoneFS  links to texMath
"texMathZoneG   links to texMath
"texMathZoneGS  links to texMath
"texMathZoneH   links to texMath
"texMathZoneHS  links to texMath
"texMathZoneI   links to texMath
"texMathZoneIS  links to texMath
"texMathZoneJ   links to texMath
"texMathZoneK   links to texMath
"texMathZoneKS  links to texMath
"texMathZoneL   links to texMath
"texMathZoneV   links to texMath
"texMathZoneW   links to texMath
"texMathZoneX   links to texMath
"texMathZoneY   links to texMath
"texMathZoneZ   links to texMath
"texNewCmd      links to Statement
"texNewEnv      links to Statement
"texOnlyMath    links to texError
"texOption      links to Number
"texParaZone    cleared
"texParen       cleared
"texPartZone    cleared
"texRefOption   cleared
"texRefZone     links to Special
"texSection     links to PreCondit
"texSectionMarker links to texCmdName
"texSectionModifier cleared
"texSectionName links to texSection
"texSectionZone cleared
"texSpaceCode   links to texStatement
"texSpaceCodeChar links to Special
"texSpecialChar links to SpecialChar
"texStatement   links to Statement
"texString      links to String
"texStyle       cleared
"texStyleMatcher cleared
"texStyleStatement links to texStatement
"texSubParaZone cleared
"texSubSectionZone cleared
"texSubSubSectionZone cleared
"texSubscript   links to texStatement
"texSubscripts  cleared
"texSuperscript links to texStatement
"texSuperscripts cleared
"texSyncMathZoneA cleared
"texSyncMathZoneAS cleared
"texSyncMathZoneB cleared
"texSyncMathZoneBS cleared
"texSyncMathZoneC cleared
"texSyncMathZoneCS cleared
"texSyncMathZoneD cleared
"texSyncMathZoneDS cleared
"texSyncMathZoneE cleared
"texSyncMathZoneES cleared
"texSyncMathZoneF cleared
"texSyncMathZoneFS cleared
"texSyncMathZoneG cleared
"texSyncMathZoneGS cleared
"texSyncMathZoneH cleared
"texSyncMathZoneHS cleared
"texSyncMathZoneI cleared
"texSyncMathZoneIS cleared
"texSyncMathZoneJ cleared
"texSyncMathZoneK cleared
"texSyncMathZoneKS cleared
"texSyncMathZoneL cleared
"texSyncStop    cleared
"texTitle       cleared
"texTodo        links to Todo
"texType        links to Type
"texTypeSize    links to texType
"texTypeStyle   links to texType
"texZone        links to PreCondit
