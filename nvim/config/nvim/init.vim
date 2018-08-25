" nvim settings
"
"  
"
" ================
" general settings
" ================
set number " line number
set title  " file title
set mouse=a " mouse compatibility
set nowrap " do not divide the line if it is too long
set cursorline " highlight the current line
set colorcolumn=80 " show column limit

" text options
set autoindent
set tabstop=4
set shiftwidth=4
set softtabstop=4
" set shiftround
set expandtab " insert spaces instead of tabs

" language options
set spelllang=en,es " diccionarios del autocorrector




" =================
" vim-plug
" =================
"
" installs vim-plug
if empty(glob("~/.config/nvim/autoload/plug.vim"))
    silent !curl -fLso ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
end

" vim-plug plugins init
call plug#begin("~/.config/nvim/plugged/")


Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'w0rp/ale' " analizador estático de código



" vim-plug plugins end
call plug#end()






" ================
" config
" ================

" NERDtree
map <F2> :NERDTreeToggle<CR> " abrir y cerrar nerdtree con F2

" Vim-Airline
let g:airline#extensions#tabline#enable = 1 " Mostrar buffers abiertos(como pestañas)
" let g:airline#extensions#tabline#fnamemod = ':t' Mostrar sólo el nombre del archivo
" let g:airline_powerline_font = 1 " requiere powerline
set noshowmode " ocultar el modo actual, que ya aparece en la barra

" indentLine
let g:indentLine_fileTypeExclude = ['text', 'sh', 'help', 'terminal']
let g:indentLine_bufNameExclude = ['NERD_tree.*', 'term:.*']

" ale analizador estático
" Mostrar mejores mensajes de error
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'




