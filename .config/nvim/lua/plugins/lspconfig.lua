return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Capabilities для nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Python
      vim.lsp.config("pyright", {
        settings = {
          pyright = {
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none",
                reportUnusedVariable = "none",
              },
            },
          },
        },
      })     

      vim.lsp.config("ruff", {
        init_options = {
          settings = {
            lint = {
              select = { "E", "F", "UP", "N", "I", "ASYNC", "S", "PTH" },
            },
            lineLength = 79,
            respectGitignore = true,
          },
        },
      })

    -- require("lsp_signature").setup({
    --   bind = true,
    --   handler_opts = { border = "rounded" },
    -- })

      -- Активация сервера
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")

      -- 4. Глобальные маппинги диагностики
      vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

      -- 5. Маппинги LSP при подключении к буферу
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "lD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "ld", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "lk", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "li", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set({ "n", "v" }, "<space>r", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
      --
      -- -- Хоткеи при подключении LSP
      -- vim.api.nvim_create_autocmd("LspAttach", {
      --   group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      --   callback = function(ev)
      --     local opts = { buffer = ev.buf }
      --     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      --     vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      --     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      --     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      --     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      --   end,
      -- })
    end,
  },
}
