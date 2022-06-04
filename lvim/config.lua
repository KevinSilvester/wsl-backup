local cmp = require('cmp')

-- general
lvim.log.level = 'warn'
lvim.format_on_save = false
lvim.colorscheme = 'kanagawa'
lvim.builtin.treesitter.indent.enable = false

vim.o.shell = '/usr/bin/bash'
vim.o.conceallevel = 0
vim.o.showmode = true
vim.o.relativenumber = true

vim.o.smartcase = true
vim.o.smarttab = true
vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 3
vim.o.softtabstop = 3
vim.o.showtabline = 3
vim.o.shiftwidth = 3
vim.o.autoindent = true
vim.o.copyindent = true
vim.o.wrap = true

-- enable autocomment
vim.api.nvim_command([[ autocmd BufEnter *.* :silent :set formatoptions=jcroql ]])
-- vim.api.nvim_command([[ autocmd BufRead,BufNewFile *.blade.php :set filetype=blade ]])

-- lualine
lvim.builtin.lualine.sections.lualine_a = { 'mode' }
lvim.builtin.lualine.sections.lualine_z = { "os.date('%a %d-%m')" }

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = 'space'
-- add your own keymapping
lvim.keys.normal_mode['<C-s>'] = ':w<cr>'
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, 'telescope.actions')
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
    ['<C-n>'] = actions.cycle_history_next,
    ['<C-p>'] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ['<C-j>'] = actions.move_selection_next,
    ['<C-k>'] = actions.move_selection_previous,
  },
}

lvim.builtin.cmp.mapping['<C-e>'] = function(fallback)
  cmp.mapping.abort()
  local copilot_keys = vim.fn['copilot#Accept']()
  if copilot_keys ~= '' then
    vim.api.nvim_feedkeys(copilot_keys, 'i', true)
  else
    fallback()
  end
end

lvim.builtin.terminal.open_mapping = '<C-b>'

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings['t'] = {
  name = '+Trouble',
  r = { '<cmd>Trouble lsp_references<cr>', 'References' },
  f = { '<cmd>Trouble lsp_definitions<cr>', 'Definitions' },
  d = { '<cmd>Trouble lsp_document_diagnostics<cr>', 'Diagnostics' },
  q = { '<cmd>Trouble quickfix<cr>', 'QuickFix' },
  l = { '<cmd>Trouble loclist<cr>', 'LocationList' },
  w = { '<cmd>Trouble lsp_workspace_diagnostics<cr>', 'Diagnostics' },
}

lvim.builtin.which_key.mappings['C'] = {
  name = '+Cmake Helper',
  c = { '<cmd>TermExec cmd="ch --clear"<cr>', 'Clear Project' },
  i = { '<cmd>TermExec cmd="ch --init"<cr>', 'Initialize' },
  b = { '<cmd>TermExec cmd="ch --build && ch --run"<cr>', 'Build and Run' },
  r = { '<cmd>TermExec cmd="ch --run"<cr>', 'Run' },
  w = {
    b = { '<cmd>TermExec cmd="ch win --build && ch win --run"<cr>', 'Build and Run Windows' },
    r = { '<cmd>TermExec cmd="ch win --run"<cr>', 'Run Windows' },
  }
}
lvim.builtin.which_key.mappings['n'] = {
  name = '+NvimTree',
  f = { '<cmd>NvimTreeFocus<cr>', 'Focus' },
  r = { '<cmd>NvimTreeRefresh<cr>', 'Refresh' },
  p = {
    name = '+TreeMenu',
    a = { '<cmd>!echo hello world<cr>', 'Echo' },
  },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  'bash',
  'c',
  'javascript',
  'json',
  'lua',
  'python',
  'typescript',
  'tsx',
  'css',
  'rust',
  'java',
  'yaml',
}

lvim.builtin.treesitter.ignore_install = { 'haskell' }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
vim.list_extend(lvim.lsp.override, { 'clangd', 'sqls', 'intelephense' })

local clangd_flags = {
  '--all-scopes-completion',
  '--suggest-missing-includes',
  '--background-index',
  '--pch-storage=disk',
  '--cross-file-rename',
  '--log=info',
  '--header-insertion=iwyu',
  '--completion-style=detailed',
  '--enable-config', -- clangd 11+ supports reading from .clangd configuration file
  '--fallback-style=Google',
}

local clangd_bin = 'clangd-12'

local clangd_opts = {
  cmd = { clangd_bin, unpack(clangd_flags) },
  on_attach = function(client, bufnr)
    require('lvim.lsp').common_on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(
      bufnr,
      'n',
      '<leader>lh',
      '<Cmd>ClangdSwitchSourceHeader<CR>',
      opts
    )
  end,
}

require('lvim.lsp.manager').setup('clangd', clangd_opts)

local sqls_opts = {
  cmd = { 'sqls' },
  -- on_attach = function(client, bufnr)
  --    require('lvim.lsp').common_on_attach(client, bufnr)
  -- end,
}

require('lvim.lsp.manager').setup('sqls', sqls_opts)

require('lvim.lsp.manager').setup('tailwindcss', {
  cmd = { 'tailwindcss-language-server' },
})

require('lvim.lsp.manager').setup('intelephense', {})

-- require('lspconfig').sqls.setup({
--    on_attach = function(client, bufnr)
--       require('sqls').on_attach(client, bufnr)
--    end,
-- })
-- local dap_install = require "dap_install"

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter, this will override the language server formatting capabilities (if it exists)
-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
-- extra_args = { "--print-with", "100" },
---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
local formatters = require('lvim.lsp.null-ls.formatters')
formatters.setup({
  {
    command = 'prettier',
    filetypes = {
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'markdown',
      'svelte',
      'typescript',
      'typescriptreact',
      'vue',
      'yaml',
    },
  },
  { exe = 'stylua', filetypes = { 'lua' } },
  {
    exe = 'blade-formatter',
    filetypes = { 'php', 'blade' },
    extra_args = {
      '--write',
      '--indent-size',
      '3',
      '--wrap-line-length',
      '100',
      '--sort-tailwindcss-classes',
    },
  },
})

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

lvim.builtin.dap.active = true

-- Additional Plugins
lvim.plugins = {
  { 'folke/tokyonight.nvim' },
  { 'rebelot/kanagawa.nvim' },
  {
    'folke/trouble.nvim',
    cmd = 'TroubleToggle',
  },
  {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && pnpm i',
    ft = 'markdown',
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    'tpope/vim-surround',
    keys = { 'c', 'd', 'y' },
    config = function()
      vim.cmd('nmap ds       <Plug>Dsurround')
      vim.cmd('nmap cs       <Plug>Csurround')
      vim.cmd('nmap cS       <Plug>CSurround')
      vim.cmd('nmap ys       <Plug>Ysurround')
      vim.cmd('nmap yS       <Plug>YSurround')
      vim.cmd('nmap yss      <Plug>Yssurround')
      vim.cmd('nmap ySs      <Plug>YSsurround')
      vim.cmd('nmap ySS      <Plug>YSsurround')
      vim.cmd('xmap gs       <Plug>VSurround')
      vim.cmd('xmap gS       <Plug>VgSurround')
    end,
  },
  -- { 'tpope/vim-fugitive' },
  { 'catppuccin/nvim', as = 'catppuccin' },
  -- { "nvim-lua/plenary.nvim" },
  { 'Shatur/neovim-cmake' },
  { 'ap/vim-css-color' },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },
  { 'nanotee/sqls.nvim' },
  { 'mattn/emmet-vim' },
  { 'scrooloose/nerdcommenter' },
  { 'jwalton512/vim-blade' },
  { 'github/copilot.vim' },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
