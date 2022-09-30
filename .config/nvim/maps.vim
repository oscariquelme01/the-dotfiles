" ---------------------
" ---- KEYBINDINGS ---- 
" ---------------------

" Remap leader key
let mapleader = " " " map leader to space

" telescope basic bindings
nnoremap ff <cmd>Telescope find_files<cr>
nnoremap fg <cmd>Telescope live_grep<cr>
nnoremap fb <cmd>Telescope buffers<cr>
nnoremap fh <cmd>Telescope help_tags<cr>
nnoremap fd <cmd>Telescope diagnostics<cr>

" clear search query string
nmap <silent> sc :let @/ = ""<CR>

" tab navigation
nnoremap <silent> tt :tabnew<CR>
nnoremap <silent> tc :tabclose<CR>
nnoremap <silent> tn :tabn<CR>
nnoremap <silent> tp :tabp<CR>

" Buffer manipulation
nnoremap <silent> zz :bd<CR>
nnoremap <silent> zn :bn<CR>

" nvim tree toggle
nnoremap <silent> fe :NvimTreeToggle<CR>

" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-up> :m .+1<CR>==gi
inoremap <A-down> :m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" don't exit visual mode when identing
vnoremap > >gv
vnoremap < <gv

" remap *iw to *w (E.G ciw to cw)
nnoremap cw ciw
nnoremap dw diw 
nnoremap yw yiw

" split mode navigation
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

" split mode resize
nnoremap <silent> <A-Left>  :vertical resize +3<CR>
nnoremap <silent> <A-Right> :vertical resize -3<CR>
nnoremap <silent> <A-Up>    :resize +3<CR>
nnoremap <silent> <A-Down>  :resize -3<CR>

" VSNIP remaps 

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)
