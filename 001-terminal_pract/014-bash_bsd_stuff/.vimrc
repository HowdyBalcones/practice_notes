call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'ycm-core/YouCompleteMe'
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'

call plug#end()

" configs for ultisnips
let g:UltiSnipsExpandTrigger="<C-e>"
let g:UltiSnipsJumpForwardTrigger="<C-r>"
let g:UltiSnipsJumpBackwardTrigger="<C-w>"


"some configurations
:set backspace=indent,eol,start
:set spell spelllang=en_gb
:let g:python3_host_prog = '/Users/23340-webster/.pyenv/versions/3.12.2/bin/python3'

" this block checks if pyenv is executable, if it's in the PATH, and if so it
" sets `g:python_host_prog` to the currently active version of python in pyenv
if executable('pyenv')
	let g:python3_host_prog = substitute(system('pyenv which python'),'\n', '', '')
endif


