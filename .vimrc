"set expandtab     
"set shiftwidth=4
"set autoindent 
"set smartindent
"set cindent
"set tabstop=4
"syntax on

:syntax on
:filetype plugin on 
:filetype indent on

""Misc
:set t_Co=256                    "I want ALL the colors :)
:set ttyfast                     "Let's try and get rid of lag
:set nocompatible                "The future is now!!
:set nobackup                    "disable that stupid backup file 'file~
:set splitbelow                  "New files go below the current
:set showmatch                   "Don't you love to know which bracket belongs to which?
:set clipboard+=unnamed          "lets yank and copy to our actual clipboard
:set encoding=UTF-8              "All new files are utf-8 encoding now :)
:set backspace=2                 "fullly backspace capable
":set number                      "sometimes number lines are useful
:set directory=~/.vim/swap       "save swap file here 
"set linebreak                   "attempt to wrap lines in a clean manner
"set wildmenu                    "hmmm....
"set wildmode=list:longest,full  "again, hmm....
":set spelllang=en             "The only spelling

""Set tabs and indents
:set tabstop=4       "tabs are now 4 columns
:set shiftwidth=4    "4 cols for indenting
:set expandtab       "use spaces instead of tab char
:set smartindent     "attempt to indent intelligently

"Status bar info and appearance
:set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\
:set laststatus=2
:set cmdheight=1
