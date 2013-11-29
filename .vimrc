set paste
set number
""""
" Vundle - packages control
"
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
 
    " let Vundle manage Vundle
    " required!
    Bundle 'gmarik/vundle'

""""
" Powerline - status bar
"
    Bundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
 
" Powerline setup
" http://askubuntu.com/questions/283908/how-can-i-install-and-use-powerline-plugin
    set encoding=utf-8 " Necessary to show Unicode glyphs
    set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
 
" Always show statusline
    set laststatus=2
    set t_Co=256v
    set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 9
    let g:Powerline_symbols = 'fancy'
    set laststatus=2
 
    Bundle 'bling/vim-airline'
     
    let g:airline_theme='powerlineish'
    let g:airline_powerline_fonts = 1

"    Bundle 'flazz/vim-colorschemes'
"    Bundle 'desert-warm-256'

""""
" A Vim plugin which shows a git diff in the 'gutter' (sign column).
"
    Bundle 'airblade/vim-gitgutter'

""""
" Color
"
    Bundle 'jonathanfilip/vim-lucius'
    color lucius
    map <F5> :call ToggleBg()<CR>
    set bg=dark
    function! ToggleBg()
        if &background == 'dark'
            set bg=light
        else
            set bg=dark
        endif
    endfunc

""""
" Syntax file
"
    Bundle 'me-vlad/python-syntax.vim'
 
""""
"  sophacles / vim-bundle-mako
"
    Bundle "sophacles/vim-bundle-mako"
    au BufNewFile,BufRead *.mako set ft=mako
 
""""
"  tmux syntax
"
    Bundle "tejr/vim-tmux"
 
""""
" Vim-Jinja2
"
    Bundle 'Glench/Vim-Jinja2-Syntax'
    au BufRead,BufNewFile *.jinja2 set filetype=jinja
 
""""
" Jinja2
"
    " Works with http://www.vim.org/scripts/script.php?script_id=2075
    " indent/htm.vim
    Bundle "lepture/vim-jinja"
    au BufNewFile,BufRead *.html,*.htm,*.shtml,*.stm,*.jinja2 set ft=jinja 
    au FileType jinja setl sw=2 ts=2 et nu
    au FileType jinja hi link htmlLink NONE
    autocmd Filetype jinja :normal gg=G


""""
" TagBar
"
    Bundle 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>

" Jedi - autocomplete
"
    Bundle 'davidhalter/jedi-vim'
    let g:jedi#show_call_signatures = 1
 
""""
" YouCompleteMe
"
"    Bundle 'Valloric/YouCompleteMe' 

""""
" Python mode
"
    Bundle 'klen/python-mode'
    " Python-mode
    " Activate rope
    " Keys:
    " K             Show python docs
    " <Ctrl-Space>  Rope autocomplete
    " <Ctrl-c>g     Rope goto definition
    " <Ctrl-c>d     Rope show documentation
    " <Ctrl-c>f     Rope find occurrences
    " <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
    " [[            Jump on previous class or function (normal, visual, operator modes)
    " ]]            Jump on next class or function (normal, visual, operator modes)
    " [M            Jump on previous class or method (normal, visual, operator modes)
    " ]M            Jump on next class or method (normal, visual, operator modes)
    let g:pymode_rope = 0
    let g:pymode_lint_ignore = "E501,C0110,W0102,F0401,C0301"
    " Documentation
    let g:pymode_doc = 1
    let g:pymode_doc_key = '<F1>'
     
    "Linting
    let g:pymode_lint = 1
    let g:pymode_lint_checker = "pyflakes,pep8"
    " Auto check on save
    let g:pymode_lint_write = 1
     
    " Support virtualenv
    let g:pymode_virtualenv = 1
     
    " Enable breakpoints plugin
    let g:pymode_breakpoint = 1
    let g:pymode_breakpoint_key = '<leader>b'
     
    " syntax highlighting
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_syntax_space_errors = g:pymode_syntax_all
    
    " Don't autofold code
    let g:pymode_folding = 0
 
    " replace pdb to ipdb
    iab ipdb import ipdb; ipdb.set_trace()

""""
" NerdTree
"
    Bundle 'scrooloose/nerdtree'
    "map <F2> :NERDTreeToggle<CR>
 
    " Автоматическое закрытие с последним окном
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
 
    " Убираем в табах путь у файлу (только название файла)
    set tabline=%!MyTabLine()
 
    function! MyTabLine()
        let s = ''
        for i in range(tabpagenr('$'))
            " select the highlighting
            if i + 1 == tabpagenr()
                let s .= '%#TabLineSel#'
            else
                let s .= '%#TabLine#'
            endif
 
            " set the tab page number (for mouse clicks)
            let s .= '%' . (i + 1) . 'T'
 
            " the label is made by MyTabLabel()
            let s .= ' %{MyTabLabel(' . (i + 1) . ')} |'
        endfor
 
        " after the last tab fill with TabLineFill and reset tab page nr
        let s .= '%#TabLineFill#%T'
 
""""""""        " right-align the label to close the current tab page
        if tabpagenr('$') > 1
            let s .= '%=%#TabLine#%999X X'
        endif
 
        "echomsg 's:' . s
        return s
    endfunction
 
    function! MyTabLabel(n)
        let buflist = tabpagebuflist(a:n)
        let winnr = tabpagewinnr(a:n)
        let numtabs = tabpagenr('$')
        " account for space padding between tabs, and the "close" button
        let maxlen = ( &columns - ( numtabs * 2 ) - 4 ) / numtabs
        let tablabel = bufname(buflist[winnr - 1])
        while strlen( tablabel ) < 4
            let tablabel = tablabel . " "
        endwhile
        let tablabel = fnamemodify( tablabel, ':t' )
        let tablabel = strpart( tablabel, 0,  maxlen )
        return tablabel
    endfunction
 
""""
" NerdTree-Tabs
"
    Bundle 'jistr/vim-nerdtree-tabs'
    map <F2> :NERDTreeTabsToggle<CR>
    let NERDTreeIgnore = ['\.pyc$']


""""
" VimCommander
"
    Bundle 'lpenz/vimcommander'
    noremap <silent> <F9> :cal VimCommanderToggle()<CR>


""""
" Other settings
"
    filetype plugin indent on

    " Use <leader>l to toggle display of whitespace
    nmap <leader>l :set list!<CR>

    " And set some nice chars to do it with
    set listchars=tab:»\ ,eol:¬

    " automatically change window's cwd to file's dir
    set autochdir

    " I'm prefer spaces to tabs
    set tabstop=4
    set shiftwidth=4
    set expandtab

    " Backspace key won't move from current line
    set backspace=indent,eol,start

    " folding
    set foldenable
    set foldmethod=indent
    set foldlevel=99

    " disable F1
    imap <F1> <nop>
    nmap <F1> <nop>

    " 256 colors
    syntax on
    if $COLORTERM == 'gnome-terminal'
      set t_Co=256
    endif

    autocmd FileType python setlocal colorcolumn=80

    set nocompatible
    filetype off

    set mousehide
    set mouse=a
    set termencoding=utf-8
    set novisualbell
    set t_vb=

    set cuc cul
    highlight CursorLine                    cterm=none ctermbg=235
    highlight CursorColumn                  cterm=none ctermbg=235
