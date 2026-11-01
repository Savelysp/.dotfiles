return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",

  dependencies = {
    "rafamadriz/friendly-snippets",
  },

  -- event = "InsertEnter",

  config = function()
    local ls = require("luasnip")

    -- Базовая настройка LuaSnip
    ls.config.setup({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      -- enable_autosnippets = true,
    })

    -- Загрузка сниппетов из friendly-snippets (VS Code формат)
    -- require("luasnip.loaders.from_vscode").lazy_load()

    -- local vscode_path = vim.g.vscode_snippets_path
    -- if vscode_path and vscode_path ~= "" then
    --   require("luasnip.loaders.from_vscode").lazy_load({ paths = { vscode_path } })
    -- end
    --
    -- local snipmate_path = vim.g.snipmate_snippets_path
    -- if snipmate_path and snipmate_path ~= "" then
    --   require("luasnip.loaders.from_snipmate").lazy_load({ paths = { snipmate_path } })
    -- end
    --
    -- local lua_path = vim.g.lua_snippets_path
    -- if lua_path and lua_path ~= "" then
    --   require("luasnip.loaders.from_lua").lazy_load({ paths = { lua_path } })
    -- end
    --
    -- Опционально: автоматическое «забывание» сниппета при выходе из insert
    -- vim.api.nvim_create_autocmd("InsertLeave", {
    --   callback = function()
    --     if ls.session.current_nodes[vim.api.nvim_get_current_buf()]
    --       and not ls.session.jump_active then
    --       ls.unlink_current()
    --     end
    --   end,
    -- })
  end,
}
