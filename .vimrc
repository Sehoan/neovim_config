" ---------------------------------------------------------------
" Vim-Plug
" ---------------------------------------------------------------

call plug#begin('~/.vim/plugged')

" Visual
Plug 'sainnhe/gruvbox-material'
Plug 'nvim-lualine/lualine.nvim'
Plug 'Yggdroot/indentLine'

" Navigation
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-smooth-scroll'

" File Navigation
Plug 'preservim/nerdtree'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'fannheyward/telescope-coc.nvim'
Plug 'airblade/vim-rooter'

" Language Server Client & Parser
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat','do': ':TSUpdate'}

" Formatter
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jparise/vim-graphql'
Plug 'jxnblk/vim-mdx-js'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

" Git Helper
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Etc
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rhubarb'
Plug 'shime/vim-livedown'

call plug#end()

" ---------------------------------------------------------------
" Basic Settings 
" ---------------------------------------------------------------

let g:mapleader = ","                   " set leader key to ,
syntax enable                           " Enables syntax highlighing
set cursorline                          " show which row my cursor is located with shade
set colorcolumn=81
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set iskeyword+=-                      	" treat dash separated words as a word text object"
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set tabstop=2                           " \t is set equal to 4 columns of whitespaces
set shiftwidth=2                        " a level of indentation is worth 4 columns of whitespaces
set softtabstop=2                       " a tab or backspace keypress is worth 4 columns of whitespaces 
set smarttab                            " interpret tab keypress differently depending on where the cursor is
set expandtab                           " Converts tabs\t to spaces
set ignorecase                          " ignore case sensitivity when searching for word
set smartcase                           " enables case sensitive searching when using capital letter in search 
set smartindent                         " automatically insert one extra level of indentation in some cases
set autoindent                          " Indent automatically depending on the previous line
set number                              " Line numbers
set background=dark                     " tell vim what the background color looks like
set scrolloff=8                         " Offset 8 from the bottom when scrolling
set noshowmode                          " We don't need to see things like -- INSERT -- anymore
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continuation of comments
set laststatus=2                        " Always show statusline
set mouse=a                             " enable mouse
set nohlsearch                            " highlight search results
set conceallevel=0                      " conceal markdown notation in .md file
set showtabline=0                       " hide tabline at the top permanently
set backupdir=$HOME/.vim/swp//
set directory=$HOME/.vim/swp//
set undodir=$HOME/.vim/swp//
" Controls how the message in command(:) is displayed() 
" t: truncate from the start, a: Abbreviate at best, F: No display for file path when editing
set shortmess=taF                      

filetype plugin on                      " turn plugin on when certain filetype is detected

if (has("termguicolors"))
  set termguicolors
endif

autocmd VimResized * wincmd =           " auto-resize vim when term window is resized 

if system('uname -s') == "Darwin\n"     " different yanking structure based on OS
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Set different number of spaces for a tab in certain filetypes (convention)
augroup filetypes_specific_configs
  autocmd FileType markdown setlocal nonumber
  autocmd FileType markdown,markdown.mdx let b:coc_enabled = 0
augroup END

"---------------------------------------------------------------
" Gruvbox Material
"---------------------------------------------------------------

let g:gruvbox_material_background = 'soft'                " hard background contrast 
let g:gruvbox_material_enable_bold = 1                    " enable bold in function names
let g:gruvbox_material_enable_italic = 1                  " enable italic for eligible fonts
let g:gruvbox_material_transparent_background = 1         " Enable transparent background
let g:gruvbox_material_visual = 'red background'          " visual selection color
let g:gruvbox_material_menu_selection_background = 'orange'  " menu selection color in popup menu
let g:gruvbox_material_sign_column_background = 'none'    " make sign column background seameless with the main pane
let g:gruvbox_material_ui_contrast = 'low'                " control sign column number contrast
let g:gruvbox_material_show_eob = 0                       " show end-of-buffer symbol ~
let g:gruvbox_material_current_word = 'bold'
let g:gruvbox_material_statusline_style = 'material'
let g:gruvbox_material_better_performance = 1             " optimize for better performance
let g:gruvbox_material_palette = 'material'               " choose among { material, mix, original }
" hi ColorColumn guibg='#1d2021'                           " Make column line invisible
colorscheme gruvbox-material
" changing floaterm colors should come after 'colorscheme' commandd
hi Floaterm guibg=#1d2021
hi FloatermBorder guibg=#1d2021 guifg=#5b7d78

" ---------------------------------------------------------------
" AutoFormatter
" ---------------------------------------------------------------

call glaive#Install()
Glaive codefmt google_java_executable="java -jar /Users/swan/Downloads/google-java-format-1.15.0-all-deps.jar"

augroup autoformat_settings
  " autocmd FileType c,cpp AutoFormatBuffer clang-format
  autocmd FileType java AutoFormatBuffer google-java-format
augroup END

" ---------------------------------------------------------------
"  Fugitive
" ---------------------------------------------------------------

noremap <leader>gs :Git<CR>

"  Smooth Scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" ---------------------------------------------------------------
"  Telescope
" ---------------------------------------------------------------

lua << END
local actions = require("telescope.actions")
require('telescope').setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      mirror = false,
      prompt_position = 'bottom'
    },
    path_display = {"smart"},
    mappings = {
      i = {
        ["<esc>"] = "close",
        ["<C-i>"] = "file_split",
        }
      },
    },
  extensions = {
    fzf = {
      fuzzy = true,                 
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
      }
    }
  }
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
END

noremap <silent><C-t> :NERDTreeClose<CR>:Telescope<CR>
noremap <silent><space>h :NERDTreeClose<CR>:Telescope help_tags<CR>

" ---------------------------------------------------------------
" NERDCommenter
" ---------------------------------------------------------------

let g:NERDSpaceDelims = 1
imap <C-c> <plug>NERDCommenterInsert
let g:NERDCustomDelimiters={
	\ 'javascriptreact': { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' },
	\ 'typescriptreact': { 'left': '//', 'right': '', 'leftAlt': '/*', 'rightAlt': '*/' },
\}

" ---------------------------------------------------------------
"  Lua Line
" ---------------------------------------------------------------

lua << END
require'lualine'.setup {
  options = {
    theme = 'auto',
    },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {''},
    lualine_y = {'fileformat'},
    lualine_z = {'filetype'},
    },
  inactive_sections = {
    lualine_a = {''},
    lualine_b = {''},
    lualine_c = {'filename'},
    lualine_x = {''},
    lualine_y = {''},
    lualine_z = {'filetype'},
    },
  extensions = {'nerdtree', 'fzf', 'fugitive'}
  }
END

" ---------------------------------------------------------------
" Treesitter
" ---------------------------------------------------------------

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "dockerfile",
    "dot",
    "go",
    "graphql",
    "hcl",
    "html",
    "java",
    "javascript",
    "json",
    "json5",
    "latex",
    "lua",
    "php",
    "python",
    "regex",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "yaml"
  },
}
EOF

" ---------------------------------------------------------------
" Vim-Rooter
" ---------------------------------------------------------------

let g:rooter_patterns = ['!.vimrc', '.git']  " set a directory that has patterns(dir or file) as a root
let g:rooter_silent_chdir = 1                " Suppress 'pwd has changed' notification

" ---------------------------------------------------------------
" IndentLine
" ---------------------------------------------------------------

let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1

let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['nerdtree', 'jsonc', 'json', 'vim',
      \ 'help', 'fzf', 'markdown', 'markdown.mdx']

autocmd FileType markdown,markdown.mdx set conceallevel=0   " prevent code blocks with ``` from disappearing

" ---------------------------------------------------------------
" Sneak
" ---------------------------------------------------------------

let g:sneak#label = 1       " enable label mode
let g:sneak#use_ic_scs = 1  " case insensitive
hi SneakScope guibg=#b85651
hi SneakScope guifg=white

" ---------------------------------------------------------------
" Markdown Live Preview
" ---------------------------------------------------------------

nmap gm :LivedownPreview<CR>

" ---------------------------------------------------------------
" FZF-vim
" ---------------------------------------------------------------

" Search for only file content, not file name
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number 
      \ --no-heading --color=always --smart-case 
      \ -g '!{node_modules/*,.git/*}' -g '!package-lock.json' ".shellescape(<q-args>),
      \ 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..', }), <bang>0)

" Grep a keyword in all files
map <silent><leader>/ :Rg!<CR>
" Grep a keyword currently on the cursor
nnoremap <silent><space>/ :Rg! <C-R><C-W><CR>

map <silent><C-p> :NERDTreeClose<CR>:Files<CR>
map <silent><leader>m :NERDTreeClose<CR>:History<CR>
map <silent><leader>l :BLines<CR>

let g:fzf_action = {
      \ 'ctrl-i': 'split',
      \ 'ctrl-v': 'vsplit' }

" Style fzf layout
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height':
      \ 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_preview_window = ['down:80%:hidden', 'ctrl-l']

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
      \ { 
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'Ignore'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] 
        \ }

" ---------------------------------------------------------------
" Floaterm
" ---------------------------------------------------------------

let g:floaterm_title = '  $1/$2'   " Format the title with the following string
let g:floaterm_wintype = 'float'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.8
let g:floaterm_borderchars = '─│─│╭╮╯╰'
let g:floaterm_opener = 'vsplit'

" Key Mappings to control floaterm
map <silent> <leader>t :NERDTreeClose<CR>:FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>

tnoremap <silent> <leader>d <C-\><C-n>:FloatermKill<CR>
tnoremap <silent> <leader>h <C-\><C-n>:FloatermPrev<CR>
tnoremap <silent> <leader><leader> <C-\><C-n>

" ---------------------------------------------------------------
" Buffer Explorer 
" ---------------------------------------------------------------

map <leader>o <leader>be
let g:bufExplorerShowNoName=1 
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowDirectories=0
let g:bufExplorerShowTabBuffer=1

" ---------------------------------------------------------------
" Code Completion (CoC)
" ---------------------------------------------------------------

map <silent><leader>r :CocRestart<CR>

let g:coc_filetype_map = {
      \ 'text' : 'markdown'
      \ }
" Set cwd to django project directory so pyright behaves correctly
" Every django project contains manage.py in its root directory
autocmd FileType python let b:coc_root_patterns = ['.git', 'manage.py']

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use enter to select the item in the menu instead of default enter behaviour

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gh :CocCommand clangd.switchSourceHeader<cr>

" Jump to definition by opening a split
nmap <silent> gi :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Show list of code actions that can fix the problem on the current cursor
" position
nmap <leader>do <Plug>(coc-codeaction)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.3 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ---------------------------------------------------------------
" NerdTree 
" Eliminate unnecessary signcolumn line on the left side of NERDTree
augroup nerdtree
  autocmd FileType nerdtree setlocal signcolumn=no 
  autocmd FileType nerdtree setlocal nomodifiable
  autocmd FileType nerdtree setlocal nocursorcolumn
augroup END

" Toggle
map <silent> <leader>n :NERDTreeToggle<cr><C-w>=  "<C-w>= to resize all split windwos equally
map <silent> <leader>f :NERDTreeFind<cr>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Close vim if nerdtree is the only window opened
" !! This causes bd not to work properly because when bd runs, nerdtree is the
" only window opened so it closes vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
      \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Change current working directory based on the current tree root
"let NERDTreeChDirMode = 2

" Show hidden files by default
"let NERDTreeShowHidden = 1

" open nerdtree on the left side
let g:NERDTreeWinPos = "left"

" Nerdtree window size
let NERDTreeWinSize = 30

let NERDTreeNaturalSort = 1

" Disables the 'Bookmarks' label ? for help' text
let NERDTreeMinimalUI = 1

let NERDTreeCascadeSingleChildDir=0
let NERDTreeCascadeOpenSingleChildDir=0
"Automatically delete the buffer of the file you just deleted with NerdTree:
let NERDTreeAutoDeleteBuffer = 1

" Open vertical split with v
let NERDTreeMapOpenVSplit = "v"

" Close NERDTree when opening a file
let NERDTreeQuitOnOpen = 1

" ---------------------------------------------------------------
" KeyMapping 
" ---------------------------------------------------------------

" Editing files
map <silent> <leader>q :q<cr>
map <silent> <leader>w :w<cr>
map <silent> <leader>fq :q!<cr>
map <silent> <leader>wa :wa<cr>

" Move between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-h> <C-w>h

map gJ <C-w>J
map gK <C-w>K
map gL <C-w>L
map gH <C-w>H

" Jump to the previous file
map <space>j <c-^>zz

" Disable recording when q pressed
map q <Nop>

" treah ctrl-h as backspace so it deletes auto created matching pairs
imap <c-h> <bs>

" Scroll with arrow keys
map <up> <c-y>
map <down> <c-e>

" Move cursor to matching pair
map mm %

" Make Y behave like other D or C
map Y y$

" Navigate to the start and end of the current line easily
map H ^
map L $

" Center the screen to the current search text
nnoremap n nzz
nnoremap N Nzz

noremap <silent><leader>so :so ~/.vimrc<CR>

" Automatically source vimrc on save.
autocmd! bufwritepost ~/.vimrc source $MYVIMRC
