"
" The colours of compassionate chaos
"
" Maintainer: Trevor McDonell <trevor.mcdonell@gmail.com>
"

if &background == "light"
  let s:foreground = "4d4d4d"     " grey24
  let s:background = "ffffff"     " white
  let s:selection  = "d6d6d6"     " grey80
  let s:line       = "efefef"
  let s:comment    = "8e908c"
  let s:red        = "c82829"
  let s:orange     = "ffc125"     " goldenrod1
  let s:yellow     = "eab700"
  let s:search     = s:yellow
  let s:green      = "718c00"
  let s:aqua       = "3e999f"
  let s:blue       = "4271ae"
  let s:purple     = "8959a8"
  let s:window     = "efefef"
  let s:magenta    = "8b008b"
else
  let s:foreground = "cccccc"
  let s:background = "2d2d2d"
  let s:selection  = "515151"
  let s:line       = "393939"
  let s:comment    = "999999"
  let s:red        = "f2777a"
  let s:orange     = "f99157"
  let s:yellow     = "ffcc66"
  let s:search     = "8b118b"
  let s:green      = "99cc99"
  let s:aqua       = "66cccc"
  let s:blue       = "6699cc"
  let s:purple     = "cc99cc"
  let s:window     = "4d5057"
endif

highlight clear
syntax reset

let colors_name = "chaos"


if has("gui_running") || &t_Co == 88 || &t_Co == 256

  " Helper functions
  " ================
  "
  " Stolen from the tomorrow theme

  " Returns an approximate grey index for the given grey level
  fun <SID>grey_number(x)
    if &t_Co == 88
      if a:x < 23
        return 0
      elseif a:x < 69
        return 1
      elseif a:x < 103
        return 2
      elseif a:x < 127
        return 3
      elseif a:x < 150
        return 4
      elseif a:x < 173
        return 5
      elseif a:x < 196
        return 6
      elseif a:x < 219
        return 7
      elseif a:x < 243
        return 8
      else
        return 9
      endif
    else
      if a:x < 14
        return 0
      else
        let l:n = (a:x - 8) / 10
        let l:m = (a:x - 8) % 10
        if l:m < 5
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual grey level represented by the grey index
  fun <SID>grey_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 46
      elseif a:n == 2
        return 92
      elseif a:n == 3
        return 115
      elseif a:n == 4
        return 139
      elseif a:n == 5
        return 162
      elseif a:n == 6
        return 185
      elseif a:n == 7
        return 208
      elseif a:n == 8
        return 231
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 8 + (a:n * 10)
      endif
    endif
  endfun

  " Returns the palette index for the given grey index
  fun <SID>grey_colour(n)
    if &t_Co == 88
      if a:n == 0
        return 16
      elseif a:n == 9
        return 79
      else
        return 79 + a:n
      endif
    else
      if a:n == 0
        return 16
      elseif a:n == 25
        return 231
      else
        return 231 + a:n
      endif
    endif
  endfun

  " Returns an approximate colour index for the given colour level
  fun <SID>rgb_number(x)
    if &t_Co == 88
      if a:x < 69
        return 0
      elseif a:x < 172
        return 1
      elseif a:x < 230
        return 2
      else
        return 3
      endif
    else
      if a:x < 75
        return 0
      else
        let l:n = (a:x - 55) / 40
        let l:m = (a:x - 55) % 40
        if l:m < 20
          return l:n
        else
          return l:n + 1
        endif
      endif
    endif
  endfun

  " Returns the actual colour level for the given colour index
  fun <SID>rgb_level(n)
    if &t_Co == 88
      if a:n == 0
        return 0
      elseif a:n == 1
        return 139
      elseif a:n == 2
        return 205
      else
        return 255
      endif
    else
      if a:n == 0
        return 0
      else
        return 55 + (a:n * 40)
      endif
    endif
  endfun

  " Returns the palette index for the given R/G/B colour indices
  fun <SID>rgb_colour(x, y, z)
    if &t_Co == 88
      return 16 + (a:x * 16) + (a:y * 4) + a:z
    else
      return 16 + (a:x * 36) + (a:y * 6) + a:z
    endif
  endfun

  " Returns the palette index to approximate the given R/G/B colour levels
  fun <SID>colour(r, g, b)
    " Get the closest grey
    let l:gx = <SID>grey_number(a:r)
    let l:gy = <SID>grey_number(a:g)
    let l:gz = <SID>grey_number(a:b)

    " Get the closest colour
    let l:x = <SID>rgb_number(a:r)
    let l:y = <SID>rgb_number(a:g)
    let l:z = <SID>rgb_number(a:b)

    if l:gx == l:gy && l:gy == l:gz
      " There are two possibilities
      let l:dgr = <SID>grey_level(l:gx) - a:r
      let l:dgg = <SID>grey_level(l:gy) - a:g
      let l:dgb = <SID>grey_level(l:gz) - a:b
      let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
      let l:dr = <SID>rgb_level(l:gx) - a:r
      let l:dg = <SID>rgb_level(l:gy) - a:g
      let l:db = <SID>rgb_level(l:gz) - a:b
      let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
      if l:dgrey < l:drgb
        " Use the grey
        return <SID>grey_colour(l:gx)
      else
        " Use the colour
        return <SID>rgb_colour(l:x, l:y, l:z)
      endif
    else
      " Only one possibility
      return <SID>rgb_colour(l:x, l:y, l:z)
    endif
  endfun

  " Returns the palette index to approximate the 'rrggbb' hex string
  fun <SID>rgb(rgb)
    let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
    let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
    let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

    return <SID>colour(l:r, l:g, l:b)
  endfun

  " Sets the highlighting for the given group
  fun <SID>X(group, fg, bg, attr)
    if a:fg != ""
      exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
    endif
    if a:bg != ""
      exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
    endif
    if a:attr != ""
      exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
    endif
  endfun

  " Vim Highlighting
  " ================

  call <SID>X("Normal", s:foreground, s:background, "")
  call <SID>X("LineNr", s:selection, s:line, "")
  call <SID>X("NonText", s:selection, "", "")
  call <SID>X("SpecialKey", s:selection, "", "")
  call <SID>X("Search", s:foreground, s:search, "")
  call <SID>X("IncSearch", "", "", "reverse")
  call <SID>X("TabLine", s:window, s:foreground, "reverse")
  call <SID>X("TabLineFill", s:window, s:foreground, "reverse")
  call <SID>X("StatusLine", s:window, s:yellow, "reverse")
  call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
  call <SID>X("VertSplit", s:window, s:window, "none")
  call <SID>X("Visual", "", s:selection, "")
  call <SID>X("Directory", s:blue, "", "")
  call <SID>X("ModeMsg", s:green, "", "")
  call <SID>X("MoreMsg", s:green, "", "")
  call <SID>X("Question", s:green, "", "")
  call <SID>X("WarningMsg", s:red, "", "")
  call <SID>X("MatchParen", "", s:selection, "")
  call <SID>X("Folded", s:comment, s:background, "")
  call <SID>X("FoldColumn", "", s:background, "")
  call <SID>X("Error", s:red, "", "")
  if version >= 700
    call <SID>X("CursorLine", "", s:line, "none")
    call <SID>X("CursorColumn", "", s:line, "none")
    call <SID>X("PMenu", s:foreground, s:selection, "none")
    call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
    call <SID>X("SignColumn", "", s:background, "none")
    call <SID>X("SpellBad", s:red, s:background, "undercurl")
    call <SID>X("SpellCap", s:aqua, s:background, "undercurl")
    call <SID>X("SpellLocal", s:aqua, s:background, "undercurl")
    call <SID>X("SpellRare", s:purple, s:background, "undercurl")
  end
  if version >= 703
    call <SID>X("ColorColumn", "", s:line, "none")
  end

  " Standard Highlighting
  call <SID>X("Comment", s:comment, "", "italic")
  call <SID>X("Todo", s:comment, s:background, "bold")
  call <SID>X("Title", s:comment, "", "")
  call <SID>X("Identifier", s:red, "", "none")
  call <SID>X("Statement", s:foreground, "", "")
  call <SID>X("Conditional", s:foreground, "", "")
  call <SID>X("Repeat", s:foreground, "", "")
  call <SID>X("Structure", s:purple, "", "")
  call <SID>X("Function", s:blue, "", "")
  call <SID>X("Constant", s:orange, "", "")
  call <SID>X("Keyword", s:orange, "", "")
  call <SID>X("String", s:green, "", "")
  call <SID>X("Special", s:foreground, "", "")
  call <SID>X("PreProc", s:orange, "", "")
  call <SID>X("SpecialComment", s:orange, "", "italic")
  call <SID>X("Operator", s:aqua, "", "none")
  call <SID>X("Type", s:blue, "", "none")
  call <SID>X("Define", s:purple, "", "none")
  call <SID>X("Include", s:blue, "", "")
  call <SID>X("Ignore", "666666", "", "")

  " Vim Highlighting
  call <SID>X("vimCommand", s:red, "", "none")

  " Git
  call <SID>X("diffAdded", s:green, "", "")
  call <SID>X("diffRemoved", s:red, "", "")
  call <SID>X("gitcommitSummary", "", "", "bold")

  " Haskell
  call <SID>X("hsImport", s:orange, "", "")
  call <SID>X("hsImportKeyword", s:orange, "", "")
  call <SID>X("hsKeyword", s:blue, "", "")
  call <SID>X("hsConditional", s:orange, "", "")
  call <SID>X("hsStructure", s:blue, "", "")
  call <SID>X("hsExprKeyword", s:orange, "", "")
  call <SID>X("hsStatement", s:purple, "", "")
  call <SID>X("hsIdentifier", s:foreground, "", "")
  " call <SID>X("hsType", s:magenta, "", "")

  call <SID>X("cabalIdentifier", s:blue, "", "")
  call <SID>X("cabalStatement", s:orange, "", "")
  call <SID>X("cabalConditional", s:orange, "", "")

  " Delete Functions
  delf <SID>X
  delf <SID>rgb
  delf <SID>colour
  delf <SID>rgb_colour
  delf <SID>rgb_level
  delf <SID>rgb_number
  delf <SID>grey_colour
  delf <SID>grey_level
  delf <SID>grey_number
endif

" " First list all groups common to both 'light' and 'dark' background
" " ------------------------------------------------------------------

" " `:he highlight-groups`
" hi ErrorMsg     guibg=Firebrick2 guifg=White
" hi FoldColumn   guibg=Grey guifg=DarkBlue
" hi Folded       guibg=#E6E6E6 guifg=DarkBlue
" hi IncSearch    gui=reverse
" hi ModeMsg      gui=bold
" hi MoreMsg      gui=bold guifg=SeaGreen4
" hi NonText      gui=bold guifg=Blue
" hi PmenuSbar    guibg=Grey
" hi PmenuSel     guifg=White guibg=SkyBlue4
" hi PmenuThumb   gui=reverse
" hi Question     gui=bold guifg=Chartreuse4
" hi SignColumn   guibg=Grey guifg=DarkBlue
" hi SpellBad     gui=undercurl guisp=Firebrick2
" hi SpellCap     gui=undercurl guisp=Blue
" hi SpellLocal   gui=undercurl guisp=DarkCyan
" hi SpellRare    gui=undercurl guisp=Magenta
" hi TabLine      gui=underline guibg=LightGrey
" hi TabLineFill  gui=reverse
" hi TabLineSel   gui=bold
" hi WarningMsg   guifg=Firebrick2

" " Syntax items (`:he group-name` -- more groups are available, these are just
" " the top level syntax items for now).
" hi Error        gui=NONE guifg=White guibg=Firebrick3
" hi Ignore       gui=NONE guifg=bg guibg=NONE
" hi Underlined   gui=underline guifg=SteelBlue1


" " Groups that differ between 'light' and 'dark' background
" " --------------------------------------------------------

" "
" " Dark background
" "
" if &background == "dark"
"   hi Boolean      gui=NONE guifg=DeepPink guibg=NONE
"   hi Comment      gui=italic guifg=#80A0FF
"   hi Constant     gui=NONE guifg=LightRed guibg=Grey5
"   hi Cursor       guibg=LightGoldenrod guifg=bg
"   hi CursorColumn guibg=Grey30
"   hi CursorIM     guibg=LightSlateGrey guifg=bg
"   hi CursorLine   guibg=Grey30
"   hi DiffAdd      guibg=DarkBlue
"   hi DiffChange   guibg=MediumPurple4
"   hi DiffDelete   gui=bold guifg=White guibg=SlateBlue
"   hi DiffText     gui=NONE guifg=White guibg=Firebrick
"   hi Directory    guifg=#16FFFF
"   hi Identifier   gui=NONE guifg=#40FFFF guibg=NONE
"   hi LineNr       guifg=LightGoldenRod guibg=Grey15
"   hi MatchParen   guifg=White guibg=Magenta
"   hi NonText      guibg=Grey25
"   hi Normal       guifg=Grey85 guibg=Grey20
"   hi Pmenu        guifg=Grey50 guibg=LightSteelBlue1
"   hi PreProc      gui=NONE guifg=LightMagenta guibg=NONE
"   hi Search       guibg=DarkMagenta guifg=NONE
"   hi Special      gui=NONE guifg=Orange guibg=Grey5
"   hi SpecialKey   guifg=Cyan
"   hi Statement    gui=bold guifg=#FFFF60 guibg=NONE
"   hi StatusLine   gui=NONE guifg=Grey85 guibg=DarkGoldenrod
"   hi StatusLineNC gui=NONE guifg=DarkGoldenrod guibg=Grey15
"   hi String       gui=NONE guifg=LightRed guibg=Grey5
"   hi Title        gui=bold guifg=Magenta
"   hi Todo         gui=NONE guifg=Green4 guibg=DeepSkyBlue1
"   hi Type         gui=bold guifg=Green1 guibg=NONE
"   hi VertSplit    gui=NONE guifg=DarkGoldenrod guibg=Grey15
"   hi WildMenu     guibg=SlateGrey guifg=White
"   hi lCursor      guibg=LightSlateGrey guifg=bg
"   if has("gui_macvim")
"     hi Visual     guibg=#845B86
"   endif

"   " Change the selection color on focus change (but only if the "chaos"
"   " colorscheme is active).
"   "
"   if has("gui_macvim")
"     au FocusLost   * if exists("colors_name") && colors_name == "chaos" | hi Visual guibg=SlateGrey | endif
"     au FocusGained * if exists("colors_name") && colors_name == "chaos" | hi Visual guibg=#845B86   | endif
"   endif
" "
" " Light backgrounds
" "
" else
"   hi Boolean      gui=NONE guifg=Red3 guibg=NONE
"   hi Comment      gui=italic guifg=Blue2 guibg=NONE
"   hi Constant     gui=NONE guifg=DarkOrange guibg=NONE
"   hi Cursor       guibg=fg guifg=bg
"   hi CursorColumn guibg=#F1F5FA
"   hi CursorIM     guibg=fg guifg=bg
"   hi CursorLine   guibg=#F1F5FA
"   hi DiffAdd      guibg=MediumSeaGreen
"   hi DiffChange   guibg=DeepSkyBlue
"   hi DiffDelete   gui=bold guifg=Black guibg=SlateBlue
"   hi DiffText     gui=NONE guibg=Gold
"   hi Directory    guifg=#1600FF
"   hi Identifier   gui=NONE guifg=Aquamarine4 guibg=NONE
"   hi LineNr       guifg=#888888 guibg=#E6E6E6
"   hi MatchParen   guifg=White guibg=MediumPurple1
"   hi Pmenu        guibg=LightSteelBlue1
"   hi PreProc      gui=NONE guifg=DodgerBlue3 guibg=NONE
"   hi Search       guibg=CadetBlue1 guifg=NONE
"   hi Special      gui=NONE guifg=BlueViolet guibg=NONE
"   hi SpecialKey   guifg=Blue
"   hi Statement    gui=bold guifg=Maroon guibg=NONE
"   hi StatusLine   gui=NONE guifg=White guibg=DarkSlateGray
"   hi StatusLineNC gui=NONE guifg=SlateGray guibg=Gray90
"   hi String       gui=NONE guifg=SkyBlue4 guibg=NONE
"   hi Title        gui=bold guifg=DeepSkyBlue3
"   hi Todo         gui=NONE guifg=DarkGreen guibg=PaleGreen1
"   hi Type         gui=bold guifg=Green4 guibg=NONE
"   hi VertSplit    gui=NONE guifg=DarkSlateGray guibg=Gray90
"   if has("gui_macvim")
"     hi Visual       guibg=MacSelectedTextBackgroundColor
"     hi Normal       gui=NONE guifg=MacTextColor guibg=MacTextBackgroundColor
"   else
"     hi Visual       guibg=#72F7FF
"     hi Normal       gui=NONE guifg=Black guibg=White
"   endif
"   hi WildMenu     guibg=SkyBlue guifg=Black
"   hi lCursor      guibg=fg guifg=bg

"   " Change the selection color on focus change (but only if the "chaos"
"   " colorscheme is active).
"   "
"   if has("gui_macvim")
"     au FocusLost   * if exists("colors_name") && colors_name == "chaos" | hi Visual guibg=MacSecondarySelectedControlColor | endif
"     au FocusGained * if exists("colors_name") && colors_name == "chaos" | hi Visual guibg=MacSelectedTextBackgroundColor   | endif
"   endif

" endif

" " vim: sw=2
