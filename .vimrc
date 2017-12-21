"" load bundles
source ~/.vim/plugins.vim

"" general settings
set autoread                    " auto-reread file if modified outside and not in vim
set autowrite                   " auto-write file before certain operations
set backup                      " leave a backup file behind on save
set encoding=utf-8              " utf-8 is default encoding
set foldmethod=syntax           " use syntax rules for folding
set formatoptions+=21           " use indent from second line of a paragraph, don't break line after single letter word
set history=1000                " save more history
set ssop+=winpos,localoptions   " save window positions and local options for :mksession
set undodir=~/.vim/undo         " place to keep undo files
set undofile                    " write undo history to undo files
set undolevels=2000             " keep this many changes in undo history
let mapleader = "\<space>"      " set the trigger key for plugins/shortcuts
syntax enable

"" whitespace
set backspace=indent,eol,start  " backspace through everything in insert mode
set expandtab                   " use spaces, not tabs
set list                        " highlight some special characters
set listchars=tab:\|\ ,trail:·,extends:»,precedes:«
set nojoinspaces                " single dot spacing<D-`>
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces
set textwidth=80                " MY TERMINAL IS OLD AND SMALL

"" searching
set gdefault                    " g flag by default for :s
set hlsearch                    " highlight matches
set ignorecase                  " searches are case insensitive...
set incsearch                   " incremental searching
set matchpairs+=<:>             " add < and > to list of "matching" brackets
set showmatch                   " flash matching bracket
set smartcase                   " ... unless they contain at least one capital letter

"" ui
set background=dark             " use dark versions of backgrounds
set cmdheight=2                 " use two lines for command-line, useful to avoid hit-enter prompts
set cursorline                  " highlight current line
set display=lastline            " display as much as possible from last line in window
set keymodel+=startsel          " shift+special key = selection
set laststatus=2                " always show status line
set lazyredraw                  " batch some screen updates during macros and such
set number                      " display current line number
set ruler                       " display coords in bottom right corner
set scrolloff=14                " leave this amount of lines while scrolling up/down
set shortmess+=mrwI             " shorter indicators (like [RO]) in messages, no :intro on start
set shortmess-=l                " verbose "x lines, y characters" in messages
set showcmd                     " display incomplete commands
set splitbelow splitright       " change splits placement
set wildmenu                    " use fancy tab-completion

"" colors
colorscheme jellybeans
" make sure vim clears trailing empty space properly on 256color terms
" http://snk.tuxfamily.org/log/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

"" autocommands
" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" disable certain backup-related settings that make crontab complain
au FileType crontab set nobackup nowritebackup
" tolerate tabs in golang
au BufRead,BufNewFile *.go set noexpandtab
" .md files are markdown, not Modula2
au BufRead,BufNewFile *.md set filetype=markdown
" open folds in newly opened files
au Syntax * normal zR

"" abbreviations
iab --- —
iab --> →
iab <-- ←
"" keyboard mappings
" stop using arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
nnoremap j gj
nnoremap k gk
" moving whole lines
nmap <C-k> ddkP
nmap <C-j> ddp
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]
" better tab
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv
" window operations
nmap <C-C> :close<cr>
" easier escape
inoremap jj <ESC>
" forgot your sudo?
cmap w!! w !sudo tee % >/dev/null
" change directory to that of current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" no yank on paste
xnoremap p pgvy
" don't move on *
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>
" keep search matches in the middle of the window
nnoremap n nzzzv
nnoremap N Nzzzv
" cd to current file's path
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" edit .vimrc
nmap <silent> <leader>rc :n $HOME/.vimrc<CR>
" use ag when it's available
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ --ignore .git5_specs
      \ --ignore review
      \ -g ""'
    let g:ctrlp_root_markers = ['OWNERS']
    let g:ctrlp_use_caching = 0
endif

"" plugin config
" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" ctrlp
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>B :CtrlPBookmarkDir<cr>
nnoremap <leader>i :CtrlPLine<cr>
nnoremap <leader>o :CtrlPMixed<cr>
nnoremap <leader>r :CtrlPMRU<cr>

let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = 'rc'
" delimitMate
let delimitMate_expand_cr = 2
let delimitMate_expand_space = 1
au FileType cpp let b:delimitMate_matchpairs = '(:),[:],{:}'
" goyo
nmap <leader>g :Goyo<CR>
" gundo
nmap <leader>G :GundoToggle<CR>
" limelight
let g:limelight_conceal_ctermfg = 'gray'
nmap <leader>L :Limelight!!<CR>
" signify
let g:signify_vcs_list = [ 'git', 'hg' ]
" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 1
" tagbar
let g:tagbar_show_linenumbers = -1
nnoremap <silent> <leader>t :TagbarToggle<CR>
" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)
" vim-indent-guide
let g:indent_guides_enable_on_vim_startup = 1
" ycm
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_key_list_previous_completion=['<Up>']
" zoomwin
nmap <silent> <leader>z :ZoomWin<CR>

" system/location dependent settings
silent! source ~/.vimrc.${LOCATION}