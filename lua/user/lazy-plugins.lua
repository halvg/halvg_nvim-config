-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  --
  --Plugins can be added in different ways:
  --a) With a link (or for a github repo: 'owner/repo' link).
  --b) By using a table, with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --c) Using a modular approach: using `require 'path/name'` will include a plugin
  -- definition from file lua/path/name.lua
  --
  -- Note:
  -- Use `opts = {}` to force a plugin to be loaded.

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  -- { 'numToStr/Comment.nvim', opts = {} }, -- "gc" to comment visual regions/lines. This is equivalent to: require('Comment').setup({})
  require 'user/kickstart/plugins/gitsigns',
  require 'user/kickstart/plugins/which-key',
  require 'user/kickstart/plugins/telescope',
  require 'user/kickstart/plugins/lspconfig',
  -- require 'user/kickstart/plugins/conform',
  require 'user/kickstart/plugins/cmp',
  require 'user/kickstart/plugins/tokyonight',
  -- require 'user/kickstart/plugins/todo-comments',
  -- require 'user/kickstart/plugins/mini',
  require 'user/kickstart/plugins/treesitter',

  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.autopairs',
  require 'user/custom/plugins/neo-tree',

  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
