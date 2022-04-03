set tabstop=3       " number of visual spaces per TAB
set softtabstop=3   " number of spaces in tab when editing
set shiftwidth=3    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent
set number
set numberwidth=4
set mouse=a         " enable mouse interaction

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


call plug#begin(stdpath('data') . '/plugged')

" fish
Plug 'dag/vim-fish'

" themes
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'rebelot/kanagawa.nvim'

" utils
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'kabouzeid/nvim-lspinstall'

Plug 'folke/todo-comments.nvim'

" Fullstack 
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'

" CoPilot
Plug 'github/copilot.vim'

call plug#end()

lua << EOF
local catppuccin = require("catppuccin")

-- configure it
catppuccin.setup(
    {
		transparent_background = false,
		term_colors = false,
		styles = {
			comments = "italic",
			functions = "NONE",
			keywords = "italic",
			strings = "NONE",
			variables = "NONE",
		},
		integrations = {
			treesitter = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = "italic",
					hints = "italic",
					warnings = "italic",
					information = "italic",
				},
				underlines = {
					errors = "underline",
					hints = "underline",
					warnings = "underline",
					information = "underline",
				},
			},
			lsp_trouble = false,
			lsp_saga = false,
			gitgutter = false,
			gitsigns = false,
			telescope = false,
			nvimtree = {
				enabled = false,
				show_root = false,
			},
			which_key = false,
			indent_blankline = {
				enabled = false,
				colored_indent_levels = false,
			},
			dashboard = false,
			neogit = false,
			vim_sneak = false,
			fern = false,
			barbar = false,
			bufferline = false,
			markdown = false,
			lightspeed = false,
			ts_rainbow = false,
			hop = false,
		},
	}
)

-- require'lspinstall'.setup() -- important

-- local servers = require'lspinstall'.installed_servers()
-- for _, server in pairs(servers) do
--    require'lspconfig'[server].setup{}
-- end

EOF

colorscheme kanagawa
