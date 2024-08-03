call plug#begin('~/.config/nvim/autoload/plugged')

	" Auto Completion
	"Plug 'neoclide/coc.nvim' , {'branch': 'release'}
	
	" Surround
	Plug 'tpope/vim-surround'

	" Autp pairs for '(' '[' '{'
	Plug 'jiangmiao/auto-pairs'
	
	"Colorizer
	Plug 'norcalli/nvim-colorizer.lua'
	Plug 'ap/vim-css-color'

	"Status line
	"Plug 'vim-airline/vim-airline'
	"Plug 'vim-airline/vim-airline-themes'
	
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
	Plug 'srcery-colors/srcery-vim'
	Plug 'sjl/badwolf'
	Plug 'nanotech/jellybeans.vim'
	Plug 'morhetz/gruvbox'
	Plug 'agude/vim-eldar'
	Plug 'arturgoms/moonbow.nvim'
	Plug 'bluz71/vim-moonfly-colors'
	Plug 'ayu-theme/ayu-vim'
	Plug 'loctvl842/monokai-pro.nvim'
	Plug 'Yazeed1s/oh-lucy.nvim'
	Plug 'askfiy/visual_studio_code'
	Plug 'bluz71/vim-nightfly-colors'
	Plug 'yunlingz/equinusocio-material.vim'
	Plug 'EdenEast/nightfox.nvim'

	call plug#end()
