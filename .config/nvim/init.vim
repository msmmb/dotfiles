source $HOME/.config/nvim/vim-plug/plugins.vim

set number relativenumber
"set number
"set cursorline
set title
set nolist
set splitright splitbelow
set smartindent
set autoindent
set nowrap
set sidescroll=1
set mouse+=a
set encoding=UTF-8
set noshowmode
"set termguicolors
"let ayucolor="mirage"
"colorscheme ayu
let mapleader="z"
highlight VertSplit cterm=NONE

let g:airline_section_z = "%l:%c  %p%% (%L)"
let g:airline_powerline_fonts = 0
"let g:airline_right_sep = ' '
"let g:airline_left_sep = ' '
"let g:airline_powerline_right_separator = ' '
"let g:airline_powerline_left_separator = ' '
"
let g:airline_statusline_ontop = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_error = 0
let g:airline_section_warning = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#right_separator = ''
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2


let g:gitgutter_enabled = 1
highlight GitGutterAdd guifg=#009900 ctermfg=Green
highlight GitGutterChange guifg=#bbbb00 ctermfg=Yellow
highlight GitGutterDelete guifg=#ff2222 ctermfg=Red
highlight clear SignColumn

"https://github.com/vim-airline/vim-airline/wiki/Screenshots

"let g:airline_theme='badwolf'
"let g:airline_theme='monochrome'
"let g:airline_theme='luna'
"let g:airline_theme='cobalt2'
"let g:airline_theme='papercolor'
"let g:airline_theme='solarized'
"let g:airline_theme='minimalist'
"let g:airline_theme='deus'
"let g:airline_theme='behelit'
let g:airline_theme='raven'
"let g:airline_theme='wombat'
"let g:airline_theme='gruvbox'
"let g:airline_theme='simple'
"let g:airline_theme='light'
"let g:airline_theme='sol'
"let g:airline_theme='powerlineish'
"let g:airline_theme='zenburn'
"let g:airline_theme='molokai'
"let g:airline_theme='serene'
"let g:airline_theme='term'
"let g:airline_theme='murmur'
"let g:airline_theme='dark'

noremap <silent> <A-Left> :vertical resize +3<CR>
noremap <silent> <A-Right> :vertical resize -3<CR>
noremap <silent> <A-Up> :resize +3<CR>
noremap <silent> <A-Down> :resize -3<CR>
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
noremap <A-m> :MinimapToggle<CR>

let g:minimap_width = 10
let g:minimap_auto_start = 0
"let g:minimap_auto_start_win_enter = 1

highlight LineNr ctermfg=DarkGrey


