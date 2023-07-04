call plug#begin('~/.config/nvim/autoload/plugged')

	" Auto Completion
	Plug 'neoclide/coc.nvim' , {'branch': 'release'}
	
	" Surround
	Plug 'tpope/vim-surround'

	" Autp pairs for '(' '[' '{'
	Plug 'jiangmiao/auto-pairs'
	
	"Colorizer
	"Plug 'norcalli/nvim-colorizer.lua'
	Plug 'ap/vim-css-color'

	"Status line
	"Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	
	" Directoy tree
	Plug 'scrooloose/nerdtree'
	
	" Icons
	Plug 'ryanoasis/vim-devicons'

	" Minimap
	Plug 'wfxr/minimap.vim'

	" Git 
	Plug 'tpope/vim-fugitive'
	Plug 'airblade/vim-gitgutter'

	" Commenter
	Plug 'preservim/nerdcommenter'

	" File finder
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'

	" Themes
	Plug 'ayu-theme/ayu-vim'
	Plug 'folke/tokyonight.nvim'
	Plug 'twerth/ir_black'
	Plug 'srcery-colors/srcery-vim'
	Plug 'sjl/badwolf'
	Plug 'nanotech/jellybeans.vim'
	Plug 'abra/vim-obsidian'
	Plug 'morhetz/gruvbox'
	Plug 'dikiaap/minimalist'
	Plug 'arturgoms/moonbow.nvim'
	Plug 'imeos/vim-colors-solstice'
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'rafalbromirski/vim-aurora'

	call plug#end()
