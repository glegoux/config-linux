" ~/.vimrc

" enable color syntax
syntax on

" show line numbers
set number

" use space instead of tab
" /!\ to do a tab, type Ctrl-V + <TAB>
set expandtab

" one tab represents X spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" keep indent on the new lines
set autoindent

" do smart indent
set smartindent

" show too long line on one unique line
set wrap!

" use color scheme monokai
colorscheme monokai
highlight Comment cterm=bold

" use 256 colors
set t_Co=256

" see white characters
set list
set listchars=nbsp:¤,tab:>-,trail:¤,extends:>,precedes:<,eol:¶,trail:·

" display the edition mode
set showmode

" display the cursor position
set ruler

" display the incomplet command
set showmode

" display the matched separator ()[]{}
set showmatch

" define encoding to read and write
" /!\ if the encoding is different :
"       - type the command ':set fileencoding=utf-8', then save.
"     if the file contains a BOM, verify with set bomb? :
"       - type the command ':set nobomb', then save.
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set nobomb

" define the end line with character
"  unix LF only (each line ends with an LF character)
"  dos  CRLF (each line ends with two characters, CR then LF)
"  mac  CR only
" /!\ see CR by typing the commande ':e ++ff=unix'
"     delete with the command ':%s/^M//' (get ^M with Ctrl-V + Ctrl-M)
set fileformat=unix

" show encoding and other information about vim
set statusline=
set statusline+=[%n]\                                "buffer number
set statusline+=%F\                                  "Filepath
set statusline+=%y\                                  "FileType
set statusline+=[encoding:%{(&fenc!=''?&fenc:&enc)}  "Encoding
set statusline+=%{(&bomb?\",BOM\":\"\")}             "Encoding
set statusline+=\ endline:%{&ff}]                    "FileFormat (dos/unix..)
set statusline+=\ %=\ [line:%l/%L\ (%p%%)\ col:%c]   "line number/total (%) column number
set statusline+=\ \ %m%r%w\ %P\ \                    "Modified? Readonly? Top/bot
set laststatus=2
