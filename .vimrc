syntax on

set guicursor=n-v-c-i:block

set encoding=utf-8
set laststatus=2
set autochdir
set ic
set hls is
set number
set relativenumber
set cursorline

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

hi clear CursorLine
augroup CLClear
    autocmd! ColorScheme * hi clear CursorLine
augroup END

autocmd VimResized * wincmd =

call plug#begin()

Plug 'windwp/nvim-autopairs'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'itchyny/lightline.vim'
Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'nvim-treesitter/nvim-treesitter', {'branch': 'main'}
Plug 'HE7086/sudoedit.nvim'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'yeddaif/neovim-purple'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'JoosepAlviste/nvim-ts-context-commentstring'

call plug#end()

colorscheme neovim_purple

highlight LineNr term=bold cterm=NONE ctermfg=DarkMagenta ctermbg=NONE gui=NONE guifg=DarkMagenta guibg=NONE

highlight CursorLineNR term=bold cterm=NONE ctermfg=Magenta ctermbg=NONE gui=NONE guifg=Magenta guibg=NONE

highlight Comment cterm=italic ctermfg=8

filetype plugin on

" Don't touch unnamed register when pasting over visual selection
xnoremap <expr> p 'pgv"' . v:register . 'y'

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

nnoremap <F5> :exec 'NERDTreeToggle' <CR>

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

lua <<EOF
-- require('ts_context_commentstring').setup {
--   enable_autocmd = false,
-- }
-- local get_option = vim.filetype.get_option
-- vim.filetype.get_option = function(filetype, option)
--   return option == "commentstring"
--     and require("ts_context_commentstring.internal").calculate_commentstring()
--     or get_option(filetype, option)
-- end

local highlight = {
    "Comment",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Comment", { fg = "#5426D3" })
end)

require("ibl").setup { indent = { highlight = highlight } }

require'nvim-treesitter'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

   indent = {
    enable = true,
    disable = { "html", "javascript" },
  },
}

require('nvim-autopairs').setup({
  enable_check_bracket_line = false,
  enable_moveright = false,
})
EOF

let g:shades_of_purple_lightline = 1
let g:lightline = { 'colorscheme': 'shades_of_purple' }

let mapleader=" "

let g:user_emmet_mode='n'
let g:user_emmet_leader_key=','

let g:NERDSpaceDelims = 1
let g:NERDCommentEmptyLines = 1

let g:closetag_filetypes = 'html,xhtml,phtml'

let g:Hexokinase_highlighters = ['backgroundfull']

let g:coc_global_extensions = [
    \ 'coc-html',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-tsserver',
    \ 'coc-java',
    \ 'coc-clangd',
    \ 'coc-pyright',
    \ 'coc-sh',
    \ 'coc-sumneko-lua',
    \ 'coc-markdownlint',
    \ ]
