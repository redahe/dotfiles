-- Name:         ntune
-- Description:  My modifications to the standard vim.lua color scheme


vim.cmd "runtime colors/vim.lua"
local hi = function(name, val)
  val.force = true
  val.cterm = val.cterm or {}
  vim.api.nvim_set_hl(0, name, val)
end

-- Matching parenthesis often the most dysfunctional think
hi('MatchParen', {fg='DarkYellow', ctermfg='DarkYellow'})

-- Tab Line


hi('TabLineFill', {fg='Black', bg='DarkGrey',  ctermfg='Black', ctermbg='DarkGrey'})
hi('TabLineSel', { fg='Black', bg='LightGrey', ctermfg='Black', bold=true, ctermbg='LightGrey'})
hi('TabLine', { bg='DarkGrey', ctermbg='DarkGrey'})

-- Markdown
hi('markdownLinkText', { fg = 'LightBlue', ctermfg='LightBlue'})
hi('markdownLinkTextDelimiter', {fg='Black', ctermfg='Black' })
hi('markdownUrl', {fg='DarkCyan', ctermfg='DarkCyan' })

-- Programming 
hi('@lsp.type.namespace',     { link = 'Identifier' })
hi('@keyword.type', { link = 'Special' })
hi('@string.escape', { link = 'Constant' })

-- Defaults
hi('ColorColumn', { bg = 'DarkGrey', ctermbg = 'DarkGrey' })
hi('CursorLine', { bg = 'Grey40', cterm = { underline = false } })
hi('CursorLineNr', { fg = 'DarkGrey', bold = true, 
                     cterm = { underline = false } })
hi('Folded', { fg = 'Magenta', bg = '', ctermfg = 'Magenta', ctermbg = '' })
hi('LineNr', { fg = 'DarkGrey', ctermfg = 'DarkGrey' })
hi('Pmenu', { bg = 'DarkGrey', ctermfg = 'LightGrey', ctermbg = 'DarkGrey' })
hi('PmenuSel', { bg = 'LightGrey', ctermfg = 'DarkGrey', ctermbg = 'LightGrey' })
hi('PmenuThumb', { bg = 'White', ctermbg = 'White' })
hi('SpellBad', { sp = 'Red', undercurl = true, ctermfg = 'Red' })
hi('Title', { fg = 'Brown', bold = true, ctermfg = 'Brown' })
hi('Comment', { fg = '#6080d0', ctermfg = 'DarkGrey' })

hi('Number', { fg = '#ffa0a0', ctermfg='LightMagenta' })
hi('Constant', { fg = '#ffa0a0', ctermfg='LightMagenta' })

hi('Special', { fg = 'DarkCyan', bold=true, ctermfg = 'DarkCyan' })
hi('Identifier', { fg = 'LightGrey', ctermfg = 'LightGrey',
                   bold = false })
hi('Statement', { fg = 'LightBlue', bold = true, ctermfg = 'LightBlue' })
hi('PreProc', { fg = '#ff7900', bold=false,    ctermfg = 'Yellow' })
hi('Type', { fg = '#15A3C7', bold=true, ctermfg = 'Cyan' })
hi('Delimiter', { fg = 'DarkCyan', bold=true, ctermfg='DarkCyan'})
hi('Character', { fg = 'brown', ctermfg='Brown' })
hi('String', { fg='Red', ctermfg='Red' })
hi('Operator', { fg = 'LightGreen', ctermfg='LightGreen' })
