-- The easiest way to use Telescope, is to start by doing something like:
--  :Telescope help_tags
--
-- Two important keymaps to use while in Telescope are:
--  - Insert mode: <c-/>
--  - Normal mode: ?
--
-- This opens a window that shows you all of the keymaps for the current
-- Telescope picker. This is really useful to discover what Telescope can
-- do as well as how to actually do it!
--

-- Function to change how filenames and paths are to be displayed
local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == '.' then
    return tail
  end
  return string.format('%s\t\t%s', tail, parent)
end

-- Autocommand for show paths less visible than filenames
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'TelescopeResults',
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd('TelescopeParent', '\t\t.*$')
      vim.api.nvim_set_hl(0, 'TelescopeParent', { link = 'Comment' })
    end)
  end,
})

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font }, -- Useful for getting pretty icons, but requires a Nerd Font.
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          initial_mode = 'normal', -- Start in normal mode insted of the default insert mode
          path_display = filenameFirst,
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.9,
            height = 0.9,
          },
          mappings = {
            n = {
              -- To toggle preview in normal mode
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
            },
            i = {
              -- To toggle preview in insert mode
              ['<M-p>'] = require('telescope.actions.layout').toggle_preview,
            },
          },
        },
        pickers = {
          buffers = {
            mappings = {
              n = {
                -- Backslash key to remove buffer when in normal mode
                ['<BS>'] = require('telescope.actions').delete_buffer + require('telescope.actions').move_to_top,
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Enable keymaps defined in user.keymaps
      require('user.keymaps').telescope_keymaps()
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
