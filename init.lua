--[[

-- This is a Nvim configuration built upon Kickstart.nvim
What is Kickstart?
  - Kickstart.nvim is *not* a distribution.
  - Kickstart.nvim is a starting point for your own configuration.
  - The goal is that you can read every line of code, top-to-bottom, understand
    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

-- Useful links and commands to know more:
    - If you don't know anything about Lua: https://learnxinyminutes.com/docs/lua/
    - After understanding a bit more about Lua, you can use `:help lua-guide` as a reference for how Neovim integrates Lua.
      - :help lua-guide (or HTML version): https://neovim.io/doc/user/lua-guide.html
    - To have a practical Neovim tutorial: run the command `:Tutor` in Neovim.
    - To have help in Neovim run AND READ `:help`.
    - Kickstart.nvim provides a keymap "<space>sh" to [s]earch the [h]elp documentation.
    - If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.


--]]

-- [[ Setting options ]]
require 'user.options'

-- [[ Basic keymaps ]]
require 'user.keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'user.lazy-bootstrap'

-- [[ Configure and install lazy.nvim plugins ]]
require 'user.lazy-plugins'
--
--  To check the current status of your plugins, run
--  :Lazy
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update

-- [[ Basic Autocommands ]] See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
