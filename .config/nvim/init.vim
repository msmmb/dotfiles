source $HOME/.config/nvim/vim-plug/plugins.vim

if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let ayucolor="dark" 
let gruvbox_contrast_dark="hard"
let $BAT_THEME='ansi'  

set termguicolors
colorscheme moonfly

set number relativenumber
"set number
"set cursorline
"set cursorcolumn
set title
set nolist
set splitright 
"set splitright splitbelow
"set smartindent
"set autoindent
"set nowrap
set sidescroll=1
set mouse+=a
"set mouse=
set encoding=UTF-8
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noshowmode
let mapleader="z"
highlight VertSplit cterm=NONE

let g:airline_section_z = "%l:%c  %p%% (%L)"
let g:airline_powerline_fonts = 0
let g:airline_right_sep = ''
"let g:airline_right_sep = ' '
"let g:airline_left_sep = ' '

let g:airline_statusline_ontop = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = 0
let g:airline_section_warning = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#right_separator = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:AutoPairs = {'{':'}'}

"https://github.com/vim-airline/vim-airline/wiki/Screenshots
let g:airline_theme='lucius'

"hi StatusLine ctermbg=white ctermfg=black
"hi TabLine  ctermbg=black ctermfg=darkgray cterm=none
"hi TabLineSel  ctermbg=black ctermfg=white
"hi TabLineFill  ctermbg=white ctermfg=black


let g:gitgutter_enabled = 1
highlight GitGutterAdd guifg=#009900 ctermfg=green
highlight GitGutterChange guifg=#bbbb00 ctermfg=yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=red
highlight clear SignColumn

noremap <silent> <Tab> :NERDTreeToggle<CR>
noremap <silent> <S-Up> :wincmd k<CR>
noremap <silent> <S-Down> :wincmd j<CR>
noremap <silent> <S-Left> :wincmd h<CR>
noremap <silent> <S-Right> :wincmd l<CR>
noremap <C-Left> :tabprevious<CR>
noremap <C-Right> :tabnext<CR>
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap Z :tabedit 
"noremap Z :Files<CR> 
noremap <C-h> 8h
noremap <C-j> 8j
noremap <C-k> 8k
noremap <C-l> 8l
noremap zz /
noremap ñ $
noremap Ñ $i<Right>
noremap aa :noh<CR>
noremap S :%s///g<Left><Left><Left>
noremap SS :.s///g<Left><Left><Left>
noremap SSS :s///g<Left><Left><Left><Left><Left>
noremap <A-m> :MinimapToggle<CR>

let g:minimap_width = 10
let g:minimap_auto_start = 0
"let g:minimap_auto_start_win_enter = 1
let g:fzf_action = { 'enter': 'tab split' }
let $FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS . ' --bind "alt-a:select-all,alt-d:deselect-all"'

highlight LineNr ctermfg=DarkGrey
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
