return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Единый вид диагностики для всех серверов
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        update_in_insert = false,
        float = { border = "rounded", source = true },
      })

      -- Capabilities для nvim-cmp
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Python: pyright
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

      -- Python: ruff
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

      -- Единственное место, где перечислены включённые серверы
      vim.lsp.enable({
        "pyright",
        "ruff",
        "rust_analyzer",
      })

      -- Диагностика
      vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, { desc = "Показать диагностику" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Предыдущая диагностика" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Следующая диагностика" })

      -- Маппинги LSP при подключении к буферу
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
        callback = function(ev)
          local map = function(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end

          map("<leader>ld", vim.lsp.buf.definition, "Определение")
          map("<leader>lD", vim.lsp.buf.declaration, "Объявление")
          map("<leader>lh", vim.lsp.buf.hover, "Подсказка")
          map("<leader>li", vim.lsp.buf.implementation, "Реализации")
          map("<leader>lr", vim.lsp.buf.references, "Ссылки")
          map("<leader>lf", function()
            vim.lsp.buf.format({ timeout_ms = 2000 })
          end, "Форматировать")

          vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, {
            buffer = ev.buf,
            desc = "Code action",
          })
        end,
      })
    end,
  },
}
