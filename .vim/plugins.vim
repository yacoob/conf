" autoinstall vim-plug if it's missing
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

let g:plug_shallow = 1
silent! call plug#begin('~/.vim/plugged')

" bundles
Plug 'bling/vim-airline'                   " status line
Plug 'brooth/far.vim'                      " find&replace on steroids
Plug 'ctrlpvim/ctrlp.vim'                  " fuzzy file/buffer/etc finder
Plug 'gregsexton/gitv'                     " gitk in vim
Plug 'inside/vim-search-pulse'             " pulse current line after search
Plug 'jremmen/vim-ripgrep'                 " rg integration
Plug 'junegunn/goyo.vim'                   " distraction-free mode
Plug 'junegunn/limelight.vim'              " dim syntax in other parts of the file
Plug 'justinmk/vim-sneak'                  " middle ground between f and /
Plug 'kana/vim-narrow'                     " emacs-style narrowing
Plug 'lilydjwg/colorizer'                  " sets background under color definitions
Plug 'luochen1990/rainbow'                 " rainbow parentheses :D
Plug 'majutsushi/tagbar'                   " tagbar
Plug 'mbbill/undotree'                     " undo tree visualisation
Plug 'mhinz/vim-signify'                   " vcs modification marks
Plug 'nathanaelkane/vim-indent-guides'     " alternating colors for indent guides
Plug 'Raimondi/delimitMate'                " auto-closing of quotes, parenthesis and brackets
Plug 'regedarek/ZoomWin'                   " toggle between single/multi window
Plug 'terryma/vim-expand-region'           " quick selection expansion for visual mode
Plug 'tpope/vim-commentary'                " quick comment out/in
Plug 'tpope/vim-fugitive'                  " git integration
Plug 'tpope/vim-surround'                  " quick 'surrounds' editing
Plug 'tpope/vim-unimpaired'                " various navigation and convenience toggles
Plug 'Valloric/ListToggle'                 " quick toggle for location and quickfist lists
Plug 'vasconcelloslf/vim-interestingwords' " arbitrary phrase highlighter
Plug 'vim-airline/vim-airline-themes'      " airline themes
Plug 'vim-scripts/CursorLineCurrentWindow' " current line highlight only in active buffer
Plug 'vim-scripts/gitignore'               " merge .gitignore into wildignore
Plug 'yuttie/comfortable-motion.vim'       " intertial scrolling

"colorschemes
Plug 'morhetz/gruvbox'

" machine specific config
silent! source ~/.vim/plugins.local.vim
call plug#end()
