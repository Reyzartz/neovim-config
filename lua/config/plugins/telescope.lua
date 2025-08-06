return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },

    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          },
          help_tags = {
            theme = 'ivy'
          }
        },
        extensions = {
          fzf = {}
        }
      }

      require('telescope').load_extension('fzf')


      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<space>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<space>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<space>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<space>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set("n", "<space>fr", builtin.lsp_references, { desc = 'Telescope find references' })
      vim.keymap.set("n", "<space>fk", builtin.keymaps, { desc = 'Telescope find keymaps' })
      vim.keymap.set("n", "<space>fs", builtin.lsp_workspace_symbols, { desc = 'Telescope find workspace symbols' })
      vim.keymap.set("n", "<space>fS", builtin.lsp_document_symbols,
        { desc = "Telescope find current document symbols" })
      vim.keymap.set("n", "<space>fw", builtin.grep_string, { desc = 'Telescope search current string in workspace' })
    end
  }
}
