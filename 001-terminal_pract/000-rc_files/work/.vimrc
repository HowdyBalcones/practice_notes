call plug#begin()
   Plug 'ycm-core/YouCompleteMe'
   Plug 'dense-analysis/ale'
   Plug 'jiangmiao/auto-pairs'
   Plug 'vim-airline/vim-airline'
   Plug 'SirVer/ultisnips'
   Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
call plug#end()

" ALE Configurations
let g:ale_linters = { 'javascript': ['eslint'], 'javascript.jsx': ['eslint'], 'markdown': ['IWE'], 'sh': [ 'language-server' ], }
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_completion_enabled = 0
let g:ale_javascript_eslint_executable = 'eslint_d'
let g:ale_sh_shellcheck_options = '-x'


" YCM Configurations
"let g:ycm_filetype_whitelist = { 'python': 1, 'cpp': 1, 'c': 1, 'javascript': 1, 'javascript.jsx': 1, }
"let g:ycm_show_diagnostics_ui=0
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_auto_trigger = 1

" configurations
set backspace=indent,eol,start
set tabstop=3
set shiftwidth=3
set expandtab
set synmaxcol=300
set hlsearch
set ttyfast
