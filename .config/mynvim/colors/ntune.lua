-- Name:         ntune
-- Description:  My modifications to the standard vim.lua color scheme


vim.cmd "runtime colors/vim.lua"
local hi = function(name, val)
  val.force = true
  val.cterm = val.cterm or {}
  vim.api.nvim_set_hl(0, name, val)
end

-- Tab Line

hi('TabLineFill', { ctermfg='Black', ctermbg='DarkGrey'})
hi('TabLineSel', { ctermfg='Black', bold=true, ctermbg='LightGrey'})

-- Markdown
hi('markdownLinkText', { fg = 'LightBlue', ctermfg='LightBlue'})
hi('markdownLinkTextDelimiter', {fg='Black', ctermfg='Black' })
hi('markdownUrl', {fg='DarkCyan', ctermfg='DarkCyan' })

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
hi('Comment', { fg = 'DarkGrey', ctermfg = 'DarkGrey' })
hi('Constant', { fg = 'Blue', ctermfg = 'Blue' })
hi('Special', { fg = 'Green', ctermfg = 'Green' })
hi('Identifier', { fg = 'LightGrey', ctermfg = 'LightGrey',
                   cterm = { bold = false } })
hi('Statement', { fg = 'LightBlue', bold = true, ctermfg = 'LightBlue' })
hi('PreProc', { fg = 'Red',    ctermfg = 'Red' })
hi('Type', { fg = 'LightGreen', bold = true, ctermfg = 'LightGreen' })
hi('Delimiter', { fg = 'DarkCyan', bold=true,  ctermfg='DarkCyan'})
hi('Number', { fg = 'Brown', ctermfg='Brown' })
hi('Character', { fg = 'red', ctermfg='Red' })
hi('String', { fg='Cyan', ctermfg='Cyan' })
hi('Operator', { fg = 'DarkCyan', ctermfg='DarkCyan' })
