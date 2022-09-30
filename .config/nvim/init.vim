" ---------------------
" ------ IMPORTS ------ 
" ---------------------
runtime ./maps.vim
runtime ./settings.vim
runtime ./plug.vim

lua << EOF
require("configs")
EOF

colorscheme catppuccin
