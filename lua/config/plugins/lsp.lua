return {
  {
    "williamboman/mason.nvim",
    opts = {}
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "biome", "eslint", "ts_ls", "tailwindcss", "gopls" },
        automatic_installation = true,
      })
    end
  },
  {
    "WhoIsSethDaniel/mason-tool-installer",
    opts = {
      ensure_installed = {
        "biome",  -- Formatter/Linter for JS/TS
        "eslint", -- Linter
        "stylua"  -- Lua Formatter
      }
    }
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)

        -- command to format the whole buffer
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, opts)

        -- Format on save
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end

      local capabilities = require('blink.cmp').get_lsp_capabilities()


      local servers = { "lua_ls", "biome", "eslint", "ts_ls", "tailwindcss", "gopls" }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end
  }
}
