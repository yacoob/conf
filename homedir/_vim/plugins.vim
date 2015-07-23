" autoinstall vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')

" bundles
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neomru.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Valloric/ListToggle'
Plug 'bling/vim-airline'
Plug 'fatih/vim-go'
Plug 'gregsexton/gitv'
Plug 'justinmk/vim-sneak'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-signify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'regedarek/ZoomWin'
Plug 'rking/ag.vim'
Plug 'scrooloose/syntastic'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'vasconcelloslf/vim-interestingwords'
Plug 'vim-scripts/gitignore'
Plug 'zhaocai/GoldenView.Vim'

"colorschemes
Plug 'jdkanani/vim-material-theme'
Plug 'nanotech/jellybeans.vim'
"
" untested

" location/os specific bundles
silent! source ~/.vim/plugins.$LOCATION.vim
silent! source ~/.vim/plugins.$OS.vim
call plug#end()
