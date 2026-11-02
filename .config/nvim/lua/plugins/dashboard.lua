return {
  "nvimdev/dashboard-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",

  opts = {
    theme = "doom",

    -- Что скрывать на время показа dashboard
    hide = {
      statusline = true,
      tabline    = true,
      winbar     = true,
    },

    config = {
      header = {
        "",
        "",
        "",
        "██╗███████╗██╗   ██╗██╗███╗   ███╗",
        "██║██╔════╝██║   ██║██║████╗ ████║",
        "██║█████╗  ██║   ██║██║██╔████╔██║",
        "██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║██║      ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝╚═╝       ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "",
        "",
        "",
      },

      center = {
        {
          icon       = "󰈚 ",
          icon_hl    = "Title",
          desc       = "Find files",
          desc_hl    = "String",
          key        = "f",
          keymap     = "SPC f f",
          key_hl     = "Number",
          key_format = " [%s]",
          action     = "Telescope find_files",
        },
        {
          icon       = "󰈚 ",
          icon_hl    = "Title",
          desc       = "Open oldfiles",
          desc_hl    = "String",
          key        = "o",
          keymap     = "SPC f o",
          key_hl     = "Number",
          key_format = " [%s]",
          action     = "Telescope oldfiles",
        },
        {
          icon       = " ",
          icon_hl    = "Title",
          desc       = "Find text",
          desc_hl    = "String",
          key        = "t",
          keymap     = "SPC f t",
          key_hl     = "Number",
          key_format = " [%s]",
          action     = "Telescope live_grep",
        },
        {
          icon       = " ",
          icon_hl    = "Title",
          desc       = "Git Branches",
          desc_hl    = "String",
          key        = "b",
          keymap     = "SPC g b",
          key_hl     = "Number",
          key_format = " [%s]",
          action     = "Telescope git_branches",
        },
      },

      vertical_center = false,
    },
  },
}
