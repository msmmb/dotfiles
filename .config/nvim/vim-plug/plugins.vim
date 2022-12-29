call plug#begin('~/.config/nvim/autoload/plugged')


	" Auto Completion
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	" Better Syntax Support
	Plug 'sheerun/vim-polyglot'

	" Surround
	Plug 'tpope/vim-surround'

	" File Explorer
	Plug 'francoiscabrol/ranger.vim'

	" Autp pairs for '(' '[' '{'
	"Plug 'jiangmiao/auto-pairs'
	
	"Colorizer
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'ap/vim-css-color'

	"Status line
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
	Plug 'airblade/vim-gitgutter'
	
	" Directoy tree
	Plug 'scrooloose/nerdtree'
	
	" Icons
	Plug 'ryanoasis/vim-devicons'

	" Minimap
	Plug 'wfxr/minimap.vim'

	" Git 
	 Plug 'tpope/vim-fugitive'

	" Commenter
	Plug 'preservim/nerdcommenter'

	" GruvBox
	Plug 'morhetz/gruvbox'

	" Ayu
	Plug 'ayu-theme/ayu-vim'

	call plug#end()
