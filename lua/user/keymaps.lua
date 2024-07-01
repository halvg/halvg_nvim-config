-- [[ Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set <space> as the leader key. See `:help mapleader`
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]
-- Remap <Esc> key in insert mode
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })

-- Clear search highlight on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>en', vim.diagnostic.goto_next, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', '<leader>ep', vim.diagnostic.goto_prev, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>es', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>el', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- File tree
vim.keymap.set('n', '<A-1>', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' })

--
-- [[ Plugin specific Keymaps ]]
-- Plugin specfic keymaps
local M = {}

-- --------------------------
-- Conform (autoformatting) key mappings
-- --------------------------
local conformFormat = function()
  require('conform').format { async = true, lsp_fallback = true }
end
vim.keymap.set('n', '<leader>f', conformFormat, { desc = '[F]ormat buffer' })
-- --------------------------
-- --------------------------

-- --------------------------
-- LSP-specific key mappings
-- --------------------------
M.lsp_keymaps = function(bufnr, client)
  local function map(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  local toggle_inlay_hints = function()
    if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(bufnr))
    end
  end

  -- ---- Key mappings for LSP-related actions ----
  -- Goto
  map('n', 'gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', 'gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('n', 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', '<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('n', '<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('n', '<leader>gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('n', '<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('n', '<leader>gt', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')
  map('n', '<leader>gy', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  -- Refactors
  map('n', '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  -- Actions
  map({ 'n', 'v' }, '<leader>li', vim.lsp.buf.code_action, 'Code Action')
  map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
  -- Additional mappings for inlay hints, if supported
  map('n', '<leader>33h', toggle_inlay_hints, '[T]oggle Inlay [H]ints')
end
-- --------------------------
-- --------------------------

-- --------------------------
-- Telescope key mappings
-- --------------------------
M.telescope_keymaps = function()
  -- See `:help telescope.builtins
  local telescope_builtin = require 'telescope.builtin'

  local find_config_files = function()
    telescope_builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end

  local search_text_this_buffer = function()
    telescope_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end

  vim.keymap.set('n', '<leader>ss', telescope_builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set('n', '<leader>sf', telescope_builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sy', telescope_builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch Workspace S[y]mbols' })
  vim.keymap.set('n', '<leader>sg', telescope_builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sif', telescope_builtin.current_buffer_fuzzy_find, { desc = '[S]earch [i]n [F]ile' })
  vim.keymap.set('n', '<leader>sh', telescope_builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', telescope_builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sw', telescope_builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sd', telescope_builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>se', telescope_builtin.resume, { desc = '[S]earch R[e]sume' })
  vim.keymap.set('n', '<leader>sr', telescope_builtin.oldfiles, { desc = '[S]earch [R]ecent Files' })
  vim.keymap.set('n', '<leader>s,', find_config_files, { desc = '[S]earch [N]eovim files' })
  vim.keymap.set('n', '<leader>/', search_text_this_buffer, { desc = '[/] Fuzzily search in current buffer' })
  vim.keymap.set('n', '<leader>bb', telescope_builtin.buffers, { desc = '[ ] Find existing buffers' })
end
-- --------------------------
-- --------------------------

-- --------------------------
-- Mini surround operations
-- --------------------------
M.mini_surround_keymaps = {
  mappings = {
    add = '<leader>asa', -- Add surrounding in Normal and Visual modes
    delete = '<leader>asd', -- Delete surrounding
    find = '<leader>asf', -- Find surrounding (to the right)
    find_left = '<leader>asF', -- Find surrounding (to the left)
    highlight = '<leader>ash', -- Highlight surrounding
    replace = '<leader>asr', -- Replace surrounding
    update_n_lines = '<leader>asn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}
-- --------------------------
-- --------------------------

return M
