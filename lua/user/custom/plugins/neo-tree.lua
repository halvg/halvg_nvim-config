-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Util functions for neotree
local function fold(state)
  local node = state.tree:get_node()
  if (node.type == 'directory' or node:has_children()) and node:is_expanded() then
    state.commands.toggle_node(state)
  else
    require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
  end
end

local function unfold(state)
  local node = state.tree:get_node()
  if node.type == 'directory' or node:has_children() then
    if not node:is_expanded() then
      state.commands.toggle_node(state)
    else
      require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
    end
  end
end

-- Neotree Installation by LazyVim
return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  -- keys = {
  --   -- { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  --   { '<A-1>', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  -- },
  opts = {
    window = {
      position = 'float',
      popup = { -- settings that apply to float position only
        size = {
          height = '80%',
          width = '80%',
        },
        position = '50%', -- 50% means center it
        -- you can also specify border here, if you want a different setting from
        -- the global popup_border_style.
      },
    },
    sources = {
      'filesystem',
      'buffers',
      'git_status',
      'document_symbols',
    },
    source_selector = {
      winbar = true, -- toggle to show selector on winbar
      sources = {
        { source = 'filesystem' },
        { source = 'buffers' },
        { source = 'git_status' },
        { source = 'document_symbols' },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['<A-1>'] = 'close_window',
          ['h'] = fold,
          ['l'] = unfold,
        },
      },
    },
  },
}
